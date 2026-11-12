//-----------------------------------------------------------------------------
// web_audio.c
// Part of the Time Pilot WebAssembly port.
//
// A very small OpenAL-compatible layer backed by the Web Audio API.  It is not
// a general OpenAL implementation: it covers the handful of entry points used
// by TimePilot-16bit-C (see AL/alut.h).
//
// Buffer ids and source ids are independent integer namespaces, exactly like
// OpenAL.  alutCreateBufferFromFile() reads the file from Emscripten's MEMFS
// (the audio/ directory is preloaded into the virtual filesystem), then asks
// the browser to decode it asynchronously.  Playing a buffer before decoding
// has finished is a silent no-op, which is also how the desktop build behaves
// when a .wav is missing.
//-----------------------------------------------------------------------------

#include <emscripten.h>
#include <stdint.h>

#include "AL/alut.h"

//-----------------------------------------------------------------------------
// All of the JavaScript side is kept in one object on the window:
//   TPAudio = {
//     ctx, buffers: { id: {decoded, loading} }, sources: { id: {buffer, loop, node, playing} },
//     nextBuffer, nextSource
//   }
//-----------------------------------------------------------------------------

EM_JS(void, web_audio_init, (void), {
    if (window.TPAudio) return;
    var AudioCtor = window.AudioContext || window.webkitAudioContext;
    if (!AudioCtor) {
        window.TPAudio = { unsupported: true, buffers: {}, sources: {},
                           nextBufferId: 1, nextSourceId: 1 };
        return;
    }
    var ctx = new AudioCtor();
    var audio = {
        ctx: ctx,
        buffers: {},
        sources: {},
        nextBufferId: 1,
        nextSourceId: 1
    };
    window.TPAudio = audio;
    // Browsers start the context suspended until a user gesture.  Resuming on
    // the first pointer/key event makes the title-screen sound work.
    function resume() {
        if (ctx.state === 'suspended') ctx.resume().catch(function () {});
    }
    window.addEventListener('pointerdown', resume, { once: true });
    window.addEventListener('keydown', resume, { once: true });
});

EM_JS(void, web_audio_resume, (void), {
    var audio = window.TPAudio;
    if (audio && audio.ctx && audio.ctx.state === 'suspended') {
        audio.ctx.resume().catch(function () {});
    }
});

EM_JS(int, web_audio_load, (const char *file_name), {
    var audio = window.TPAudio;
    if (!audio || audio.unsupported) return 0;

    var path = UTF8ToString(file_name);
    var fs = (typeof Module !== 'undefined' && Module.FS) ? Module.FS : FS;
    var bytes;
    try {
        bytes = fs.readFile(path);
    } catch (problem) {
        return 0; // A sample that the desktop build also cannot find.
    }

    var id = audio.nextBufferId++;
    var slot = { decoded: null, loading: true };
    audio.buffers[id] = slot;

    // decodeAudioData detaches the source ArrayBuffer, so hand it a copy.
    var copy = new Uint8Array(bytes.byteLength);
    copy.set(bytes);
    audio.ctx.decodeAudioData(copy.buffer).then(function (decoded) {
        slot.decoded = decoded;
        slot.loading = false;
    }).catch(function () {
        slot.loading = false;
        delete audio.buffers[id];
    });
    return id;
});

EM_JS(int, web_audio_gen_source, (void), {
    var audio = window.TPAudio;
    if (!audio || audio.unsupported) return 0;
    var id = audio.nextSourceId++;
    audio.sources[id] = { buffer: 0, loop: false, node: null, playing: false };
    return id;
});

EM_JS(void, web_audio_delete_source, (int source), {
    var audio = window.TPAudio;
    if (!audio) return;
    var src = audio.sources[source];
    if (!src) return;
    if (src.node) {
        try { src.node.onended = null; src.node.stop(); } catch (ignored) {}
        src.node = null;
    }
    src.playing = false;
    delete audio.sources[source];
});

EM_JS(void, web_audio_delete_buffer, (int buffer), {
    var audio = window.TPAudio;
    if (!audio) return;
    if (!audio.buffers[buffer]) return;
    // Sources keep their own reference to the decoded AudioBuffer.
    delete audio.buffers[buffer];
});

EM_JS(void, web_audio_bind, (int source, int buffer), {
    var audio = window.TPAudio;
    if (!audio) return;
    var src = audio.sources[source];
    if (src) src.buffer = buffer;
});

EM_JS(void, web_audio_set_loop, (int source, int looping), {
    var audio = window.TPAudio;
    if (!audio) return;
    var src = audio.sources[source];
    if (!src) return;
    src.loop = !!looping;
    if (src.node) src.node.loop = !!looping;
});

EM_JS(void, web_audio_play, (int source), {
    var audio = window.TPAudio;
    if (!audio || audio.unsupported) return;
    var src = audio.sources[source];
    if (!src || !src.buffer) return;
    var buf = audio.buffers[src.buffer];
    if (!buf || !buf.decoded) return;

    if (audio.ctx.state === 'suspended') audio.ctx.resume().catch(function () {});
    if (src.node) {
        try { src.node.onended = null; src.node.stop(); } catch (ignored) {}
        src.node = null;
    }
    var node = audio.ctx.createBufferSource();
    node.buffer = buf.decoded;
    node.loop = src.loop;
    node.connect(audio.ctx.destination);
    src.node = node;
    src.playing = true;
    node.onended = function () {
        if (src.node === node) {
            src.playing = false;
            src.node = null;
        }
    };
    node.start(0);
});

EM_JS(void, web_audio_stop, (int source), {
    var audio = window.TPAudio;
    if (!audio) return;
    var src = audio.sources[source];
    if (!src) return;
    if (src.node) {
        try { src.node.onended = null; src.node.stop(); } catch (ignored) {}
        src.node = null;
    }
    src.playing = false;
});

EM_JS(int, web_audio_is_playing, (int source), {
    var audio = window.TPAudio;
    if (!audio) return 0;
    var src = audio.sources[source];
    return src && src.playing ? 1 : 0;
});

//-----------------------------------------------------------------------------
// OpenAL / ALUT entry points.
//-----------------------------------------------------------------------------
void alutInit(int *argc, char **argv) {
    (void)argc;
    (void)argv;
    web_audio_init();
}

void alutExit(void) {
    // The Web Audio context is page-lifetime; there is nothing useful to free
    // when the game exits.  Sources are stopped instead.
    (void)0;
}

ALuint alutCreateBufferFromFile(const char *fileName) {
    web_audio_init();
    return (ALuint)web_audio_load(fileName);
}

ALenum alGetError(void) {
    return AL_NO_ERROR;
}

void alGenSources(ALint n, ALuint *sources) {
    if (n <= 0 || !sources) return;
    web_audio_init();
    for (ALint i = 0; i < n; ++i) {
        sources[i] = (ALuint)web_audio_gen_source();
    }
}

void alDeleteSources(ALint n, const ALuint *sources) {
    if (n <= 0 || !sources) return;
    for (ALint i = 0; i < n; ++i) {
        web_audio_delete_source((int)sources[i]);
    }
}

void alDeleteBuffers(ALint n, const ALuint *buffers) {
    if (n <= 0 || !buffers) return;
    for (ALint i = 0; i < n; ++i) {
        web_audio_delete_buffer((int)buffers[i]);
    }
}

void alSourcei(ALuint source, ALenum param, ALint value) {
    if (param == AL_BUFFER) {
        web_audio_bind((int)source, (int)value);
    } else if (param == AL_LOOPING) {
        web_audio_set_loop((int)source, value == AL_TRUE);
    }
}

void alGetSourcei(ALuint source, ALenum param, ALuint *value) {
    if (!value) return;
    if (param == AL_SOURCE_STATE) {
        *value = web_audio_is_playing((int)source) ? AL_PLAYING : AL_STOPPED;
    }
}

void alSourcePlay(ALuint source) {
    web_audio_init();
    web_audio_play((int)source);
}

void alSourceStop(ALuint source) {
    web_audio_stop((int)source);
}

// Exposed for the page shell: called from a user gesture.
EMSCRIPTEN_KEEPALIVE
void webAudioResume(void) {
    web_audio_resume();
}
