'use strict';

/* Time Pilot — Commander X16 web player.
 *
 * Loads the official x16-emulator WebAssembly build (r49) and copies this
 * repository's CX16 PRG and HostFS assets into the emulator's virtual drive,
 * then starts TIME_PILOT.PRG.  The page has no copy of the emulator: it is
 * downloaded by TimePilot-CX16/web/assemble.mjs when the site is built.
 */

var canvas = document.getElementById('canvas');
var boot = document.getElementById('boot');
var playBtn = document.getElementById('play');
var bootError = document.getElementById('bootError');
var errorBox = document.getElementById('error');
var statusEl = document.getElementById('status');
var soundBtn = document.getElementById('sound');
var fullscreenBtn = document.getElementById('fullscreen');
var restartBtn = document.getElementById('restart');

var started = false;
var running = false;
var failed = false;
var autoStart = new URLSearchParams(location.search).has('auto');

function say(text) { statusEl.textContent = text; }

function fail(message) {
  failed = true;
  running = false;
  say('Unable to run the game.');
  if (!boot.hidden) {
    bootError.textContent = message + ' Use “Restart” to try again.';
    bootError.hidden = false;
  } else {
    errorBox.textContent = message + ' Use “Restart” to reload the page.';
    errorBox.hidden = false;
  }
  playBtn.disabled = true;
  soundBtn.disabled = true;
  fullscreenBtn.disabled = true;
}

/* The emulator reads this global configuration before starting main(). */
var Module = {
  canvas: canvas,
  arguments: ['-prg', 'time_pilot.prg', '-run', '-ram', '512', '-scale', '1',
              '-quality', 'nearest', '-keymap', 'en-us'],
  locateFile: function (name) { return 'emulator/' + name; },
  preRun: [function () {
    if (typeof ENV !== 'undefined') ENV.SDL_EMSCRIPTEN_KEYBOARD_ELEMENT = '#canvas';
    addRunDependency('time-pilot-files');
    say('Loading the game files…');
    fetch('game/manifest.json')
      .then(function (response) {
        if (!response.ok) throw new Error('game/manifest.json (' + response.status + ')');
        return response.json();
      })
      .then(function (manifest) {
        var done = 0;
        var total = manifest.resources.length;
        return Promise.all(manifest.resources.map(function (name) {
          return fetch('game/' + name)
            .then(function (response) {
              if (!response.ok) throw new Error('game/' + name + ' (' + response.status + ')');
              return response.arrayBuffer();
            })
            .then(function (buffer) {
              FS.writeFile('/' + name, new Uint8Array(buffer));
              done += 1;
              say('Loading the game files… ' + done + '/' + total);
              return null;
            });
        }));
      })
      .then(function () { removeRunDependency('time-pilot-files'); })
      .catch(function (problem) {
        fail('The game files could not be loaded: ' + problem.message);
      });
  }],
  postRun: [function () {
    if (failed) return;
    running = true;
    boot.hidden = true;
    keepTitle();
    canvas.focus({ preventScroll: true });
    say('Running. Press 1 or 2 to start.');
    playBtn.textContent = 'Running';
    soundBtn.disabled = true;
    fullscreenBtn.disabled = !document.getElementById('screen').requestFullscreen;
    restartBtn.disabled = false;
  }],
  print: function (text) { console.log(text); },
  printErr: function (text) { console.warn(text); },
  setStatus: function (text) {
    if (text && !running && !failed) say(text);
  },
  onAbort: function () { fail('The emulator stopped unexpectedly.'); }
};

function start() {
  if (started) return;
  started = true;
  playBtn.disabled = true;
  if (typeof WebAssembly === 'undefined') {
    fail('This browser does not support WebAssembly.');
    return;
  }
  say('Loading the emulator…');
  var script = document.createElement('script');
  script.src = 'emulator/x16emu.js';
  script.onerror = function () { fail('The emulator could not be downloaded.'); };
  document.body.append(script);
}

playBtn.addEventListener('click', start);

canvas.addEventListener('click', function () { canvas.focus({ preventScroll: true }); });
canvas.addEventListener('keydown', function (event) {
  if (['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight', ' ', 'Backspace'].indexOf(event.key) >= 0) {
    event.preventDefault();
  }
});
canvas.addEventListener('contextmenu', function (event) { event.preventDefault(); });
canvas.addEventListener('mousedown', function () { canvas.focus({ preventScroll: true }); });
canvas.addEventListener('webglcontextlost', function (event) {
  event.preventDefault();
  fail('The browser lost its WebGL context.');
});

fullscreenBtn.addEventListener('click', function () {
  var screen = document.getElementById('screen');
  if (document.fullscreenElement) {
    document.exitFullscreen().catch(function () {});
  } else if (screen.requestFullscreen) {
    screen.requestFullscreen().catch(function () { say('Fullscreen is unavailable here.'); });
  }
  canvas.focus({ preventScroll: true });
});

restartBtn.addEventListener('click', function () { location.reload(); });

/* The emulator shell renames the document while it boots; keep our title. */
var pageTitle = 'Time Pilot — Commander X16';
function keepTitle() {
  if (document.title !== pageTitle) document.title = pageTitle;
}
document.title = pageTitle;
setInterval(keepTitle, 1000);

/* Keyboard focus is required for the KERNAL to see keys. */
window.addEventListener('load', function () { canvas.focus({ preventScroll: true }); });

if (autoStart) start();
