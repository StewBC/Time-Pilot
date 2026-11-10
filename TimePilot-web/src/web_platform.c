//-----------------------------------------------------------------------------
// web_platform.c
// Part of the Time Pilot WebAssembly port.
//
// tigr.c is compiled with TIGR_HEADLESS, so it keeps the software bitmap and
// PNG loader but none of the Win32/Cocoa/X11/Android backends.  This file
// supplies the few platform entry points the game calls:
//
//   tigrWindow / tigrUpdate / tigrUpdatePaced / tigrClosed
//   tigrKeyHeld / tigrKeyDown / tigrReadChar / tigrTime
//
// The bitmap is presented to a <canvas> with putImageData at the native
// 320x200 resolution; CSS scales it up with image-rendering: pixelated.
//
// Frame pacing: the game is a synchronous C while(1) loop.  tigrUpdatePaced()
// yields to the browser for the remainder of a 60 Hz frame with
// emscripten_sleep(); Emscripten's Asyncify keeps the C stack across the yield.
// The logical frame boundaries (gamePostFrame, the title/pause loops) use the
// paced variant.  Wipes and the time-warp animation use plain tigrUpdate, but
// still sleep for one display frame after presenting: without the yield the
// browser coalesces all of the centre-out radar sweep into one final frame.
//-----------------------------------------------------------------------------

#include <emscripten.h>
#include <math.h>
#include <stdint.h>
#include <string.h>

#include "tigr.h"

#define TP_KEY_COUNT 512
#define TP_CHAR_QUEUE 64

static unsigned char keyDownNow[TP_KEY_COUNT];
static unsigned char keyDownPrev[TP_KEY_COUNT];

// Set by gameStart() so the shell can distinguish a running game from the
// title/attract screen.  A native Escape quit is only safe while a game is
// active; on the title screen it would stop the C runtime instead.
static int gameActive = 0;

static char charQueue[TP_CHAR_QUEUE];
static int charHead = 0;
static int charTail = 0;

static double frameClock = 0.0;
static int frameClockInitialised = 0;

//-----------------------------------------------------------------------------
// Called from the page shell on keydown / keyup.  `key` uses the tigr key
// numbering from tigr.h (ASCII for letters/digits, 128+ for special keys).
//-----------------------------------------------------------------------------
EMSCRIPTEN_KEEPALIVE
void tpKeyEvent(int key, int down) {
    if (key <= 0 || key >= TP_KEY_COUNT) return;
    keyDownNow[key] = down ? 1 : 0;
}

//-----------------------------------------------------------------------------
// Called from the C game when it enters or leaves its play loop.  The shell
// uses this to choose between the native return-to-title path and a reload.
//-----------------------------------------------------------------------------
EMSCRIPTEN_KEEPALIVE
void tpSetGameActive(int active) {
    gameActive = active ? 1 : 0;
}

EMSCRIPTEN_KEEPALIVE
int tpIsGameActive(void) {
    return gameActive;
}

//-----------------------------------------------------------------------------
// Called from the page shell for printable key presses.  tigrReadChar() should
// see the last character typed and then clear the queue, matching tigr.
//-----------------------------------------------------------------------------
EMSCRIPTEN_KEEPALIVE
void tpCharEvent(int ch) {
    if (ch <= 0 || ch > 255) return;
    charQueue[charTail % TP_CHAR_QUEUE] = (char)ch;
    charTail = (charTail + 1) % TP_CHAR_QUEUE;
}

//-----------------------------------------------------------------------------
// Presentation.  TPixel is 4 bytes: R, G, B, A.
//-----------------------------------------------------------------------------
EM_JS(void, web_present, (const unsigned char *pixels, int w, int h), {
    var canvas = (typeof Module !== 'undefined' && Module.tpCanvas)
        ? Module.tpCanvas
        : document.getElementById('game');
    if (!canvas) return;

    if (canvas.width !== w || canvas.height !== h) {
        canvas.width = w;
        canvas.height = h;
        canvas.__tpImage = null;
    }
    var ctx = canvas.__tpContext;
    if (!ctx) ctx = canvas.__tpContext = canvas.getContext('2d');
    var image = canvas.__tpImage;
    if (!image) {
        image = canvas.__tpImage = new ImageData(w, h);
    }
    image.data.set(HEAPU8.subarray(pixels, pixels + w * h * 4));
    ctx.putImageData(image, 0, 0);
});

//-----------------------------------------------------------------------------
// Window / bitmap lifetime.
//-----------------------------------------------------------------------------
Tigr *tigrWindow(int w, int h, const char *title, int flags) {
    (void)title;
    (void)flags;
    return tigrBitmap(w, h);
}

void tigrUpdate(Tigr *bmp) {
    if (!bmp || !bmp->pix) return;
    web_present((const unsigned char *)bmp->pix, bmp->w, bmp->h);
    // Intermediate transition frames need a real browser turn.  Sixteen
    // milliseconds is one 60 Hz frame, which matches the native wipes.
    emscripten_sleep(16);
}

//-----------------------------------------------------------------------------
// One logical 60 Hz frame.  Present, then sleep until the next 16.67 ms slot.
// Present directly instead of calling tigrUpdate() so the transition-frame
// sleep is not added to the logical-frame sleep.
//-----------------------------------------------------------------------------
void tigrUpdatePaced(Tigr *bmp) {
    if (!bmp || !bmp->pix) return;
    web_present((const unsigned char *)bmp->pix, bmp->w, bmp->h);

    const double hz = 60.0;
    const double period = 1000.0 / hz;
    double now = emscripten_get_now();

    if (!frameClockInitialised) {
        frameClock = now;
        frameClockInitialised = 1;
    }
    double next = frameClock + period;
    if (now < next) {
        int millis = (int)ceil(next - now);
        if (millis > 0) {
            emscripten_sleep((unsigned int)millis);
            now += millis;
        }
        frameClock += period;
        if (frameClock < now) frameClock = now;
    } else {
        frameClock = now;
    }
}

int tigrClosed(Tigr *bmp) {
    (void)bmp;
    return 0;
}

//-----------------------------------------------------------------------------
// Keyboard.
//-----------------------------------------------------------------------------
int tigrKeyHeld(Tigr *bmp, int key) {
    (void)bmp;
    if (key <= 0 || key >= TP_KEY_COUNT) return 0;
    return keyDownNow[key] ? 1 : 0;
}

int tigrKeyDown(Tigr *bmp, int key) {
    (void)bmp;
    if (key <= 0 || key >= TP_KEY_COUNT) return 0;
    int down = keyDownNow[key] && !keyDownPrev[key];
    keyDownPrev[key] = keyDownNow[key];
    return down;
}

int tigrReadChar(Tigr *bmp) {
    (void)bmp;
    int last = 0;
    while (charHead != charTail) {
        last = (unsigned char)charQueue[charHead];
        charHead = (charHead + 1) % TP_CHAR_QUEUE;
    }
    return last;
}

//-----------------------------------------------------------------------------
// Time helper (the game only uses this with SHOW_FPS defined).
//-----------------------------------------------------------------------------
float tigrTime(void) {
    static double previous = 0.0;
    double now = emscripten_get_now() / 1000.0;
    if (previous == 0.0) {
        previous = now;
        return 0.0f;
    }
    float elapsed = (float)(now - previous);
    previous = now;
    return elapsed;
}

//-----------------------------------------------------------------------------
// Not used by Time Pilot, but declared in tigr.h.
//-----------------------------------------------------------------------------
void tigrMouse(Tigr *bmp, int *x, int *y, int *buttons) {
    (void)bmp;
    if (x) *x = 0;
    if (y) *y = 0;
    if (buttons) *buttons = 0;
}

int tigrTouch(Tigr *bmp, TigrTouchPoint *points, int maxPoints) {
    (void)bmp;
    (void)points;
    (void)maxPoints;
    return 0;
}

void tigrShowKeyboard(int show) {
    (void)show;
}

//-----------------------------------------------------------------------------
// The shell calls this when the page loses / regains focus, so a key does not
// stay stuck down while the window is in the background.
//-----------------------------------------------------------------------------
EMSCRIPTEN_KEEPALIVE
void tpClearKeys(void) {
    memset(keyDownNow, 0, sizeof(keyDownNow));
    memset(keyDownPrev, 0, sizeof(keyDownPrev));
}
