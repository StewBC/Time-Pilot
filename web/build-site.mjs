//-----------------------------------------------------------------------------
// Build the GitHub Pages site.
//
//   bash TimePilot-web/build.sh         (or the .ps1 build on Windows)
//   bash TimePilot-CX16/web/build.sh    (or the .ps1 build on Windows)
//   node web/build-site.mjs
//
// The output is web/_site.  It is a plain static directory: no server-side
// component, no Jekyll, no absolute paths.  Both playable ports are copied from
// their build outputs, and the CX16 emulator archive is downloaded and
// checksum-verified by TimePilot-CX16/web/assemble.mjs.
//-----------------------------------------------------------------------------

import {
  cpSync, existsSync, mkdirSync, readFileSync, readdirSync, rmSync, statSync,
  writeFileSync,
} from "node:fs";
import { createHash } from "node:crypto";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { assembleX16 } from "../TimePilot-CX16/web/assemble.mjs";

const here = dirname(fileURLToPath(import.meta.url));
const repo = resolve(here, "..");
const outDir = join(here, "_site");
const wasmDir = join(repo, "TimePilot-web", "dist");
const x16Dir = join(repo, "TimePilot-CX16", "web");
const wasmOut = join(outDir, "wasm");
const x16Out = join(outDir, "x16");
const macDir = join(here, "mac");
const macOut = join(outDir, "mac");
const archieDir = join(here, "archie");
const archieOut = join(outDir, "archie");

// GitHub Actions sets GITHUB_REPOSITORY for the repository that owns the
// workflow.  Using it here means the same source deploys correctly from a
// fork (for example StewBC/Time-Pilot) as well as from this working copy.
const repoSlug = process.env.GITHUB_REPOSITORY || "anomixer/Time-Pilot";
const repoUrl = `https://github.com/${repoSlug}`;
const refName = process.env.GITHUB_REF_NAME || "master";

// The IIvera .hdv release asset lives in this fork, so this one link must stay
// fixed when the site itself is deployed from upstream.
const iiveraUrl = "https://github.com/anomixer/Time-Pilot/releases/latest/download/TimePilot-IIvera.hdv";

function requireFile(path, hint) {
  if (!existsSync(path)) throw new Error(`missing ${path} — ${hint}`);
  return path;
}

function copy(source, destination) {
  mkdirSync(dirname(destination), { recursive: true });
  cpSync(source, destination, { recursive: true });
}

// Start from a clean site so stale files cannot survive between builds.
rmSync(outDir, { recursive: true, force: true });
mkdirSync(outDir, { recursive: true });
mkdirSync(join(outDir, "assets"), { recursive: true });

// Native WebAssembly player.
requireFile(join(wasmDir, "index.html"), "run TimePilot-web/build first");
requireFile(join(wasmDir, "index.wasm"), "run TimePilot-web/build first");
cpSync(wasmDir, wasmOut, { recursive: true });

// Browsers may keep the previous player HTML for a while after a deploy.
// Derive a short build id from the complete generated player, not just the
// shell, so changes to the WASM or its data also produce a fresh URL.
const wasmHash = createHash("sha256");
for (const name of ["index.html", "index.js", "index.wasm", "index.data"]) {
  wasmHash.update(readFileSync(join(wasmDir, name)));
}
const wasmVersion = wasmHash.digest("hex").slice(0, 8);

// The Macintosh disk is static, but give the landing page a cache-busting
// version too if the floppy is ever rebuilt.
const macDiskVersion = createHash("sha256")
  .update(readFileSync(join(macDir, "Time.Pilot-m68k.dsk")))
  .digest("hex")
  .slice(0, 8);

// The Archimedes page points at the HostFS zip as a static asset.  Version the
// landing-page link so a changed archive gets a fresh page URL.
const archieZipVersion = createHash("sha256")
  .update(readFileSync(join(archieDir, "TimePilot-RISCOS-HostFS.zip")))
  .digest("hex")
  .slice(0, 8);

// Commander X16 player.  assembleX16 copies the emulator, game files, shell
// and title art into the destination directory.
const x16Files = await assembleX16(x16Out, {
  cacheDir: join(x16Dir, ".cache"),
  distDir: join(x16Dir, "dist"),
  assetsDir: join(x16Dir, "assets"),
});
if (!existsSync(join(x16Out, "index.html"))) {
  throw new Error("x16 player did not produce index.html");
}

// Macintosh player: a small static page around Infinite Mac plus the game
// floppy.  Infinite Mac needs a cross-origin HEAD that exposes Content-Length;
// GitHub Pages does not expose that header to CORS, so the player reads the
// disk from raw.githubusercontent.com for whichever repository is deploying.
requireFile(join(macDir, "index.html"), "the Macintosh player page is missing");
requireFile(join(macDir, "Time.Pilot-m68k.dsk"), "the TimePilot Macintosh disk is missing");
copy(macDir, macOut);
const macPage = readFileSync(join(macOut, "index.html"), "utf8")
  .replaceAll('data-timepilot-repo="anomixer/Time-Pilot"', `data-timepilot-repo="${repoSlug}"`)
  .replaceAll('data-timepilot-ref="master"', `data-timepilot-ref="${refName}"`);
writeFileSync(join(macOut, "index.html"), macPage);

// Archimedes player: a static page around Archimedes Live plus the RISC OS
// HostFS archive.  The emulator fetches the zip over CORS and unpacks it into
// HostFS before booting; the autoboot hash on the page then starts !TimePilot.
requireFile(join(archieDir, "index.html"), "the Archimedes player page is missing");
requireFile(join(archieDir, "TimePilot-RISCOS-HostFS.zip"), "the TimePilot RISC OS archive is missing");
copy(archieDir, archieOut);

// Landing page and its title art.
copy(join(here, "index.html"), join(outDir, "index.html"));
copy(join(here, "style.css"), join(outDir, "style.css"));

// Keep the source landing page clean, but make the deployed links versioned
// and point repository links at whichever fork is doing the deployment.  The
// IIvera release URL is protected first because its asset only exists in this
// fork, not in upstream releases.
const landing = readFileSync(join(outDir, "index.html"), "utf8")
  .replaceAll(iiveraUrl, "__IIVERA_HDV__")
  .replace(/https:\/\/github\.com\/anomixer\/Time-Pilot/g, repoUrl)
  .replace(/anomixer\/Time-Pilot/g, repoSlug)
  .replaceAll("__IIVERA_HDV__", iiveraUrl)
  .replace(/href="wasm\/"/g, `href="wasm/?v=${wasmVersion}"`)
  .replace(/href="mac\/"/g, `href="mac/?v=${macDiskVersion}"`)
  .replace(/href="archie\/"/g, `href="archie/?v=${archieZipVersion}"`);
writeFileSync(join(outDir, "index.html"), landing);
for (const [source, name] of [
  [join(repo, "TimePilot-16bit-C", "sprites", "logo.png"), "timepilot-logo.png"],
  [join(repo, "TimePilot-IIgs", "png", "splash.png"), "timepilot-splash.png"],
  [join(here, "assets", "favicon.png"), "favicon.png"],
  [join(here, "assets", "favicon-180.png"), "favicon-180.png"],
  [join(here, "assets", "favicon.ico"), "favicon.ico"],
]) {
  requireFile(source, "the repository's site art is missing");
  copy(source, join(outDir, "assets", name));
}
copy(join(here, "assets", "favicon.ico"), join(outDir, "favicon.ico"));

// GitHub Pages: do not run Jekyll over a directory full of .wasm/.data files.
writeFileSync(join(outDir, ".nojekyll"), "");

const players = {
  generatedAt: new Date().toISOString(),
  players: [
    {
      id: "wasm",
      title: "TimePilot-16bit-C — native WebAssembly",
      path: "wasm/",
      kind: "in-browser",
      source: "TimePilot-16bit-C",
      runtime: "Emscripten / WebAssembly",
    },
    {
      id: "x16",
      title: "TimePilot-CX16",
      path: "x16/",
      kind: "emulated",
      source: "TimePilot-CX16",
      runtime: "llvm-mos PRG in the official x16emu WebAssembly build (r49)",
    },
    {
      id: "a2vera",
      title: "TimePilot-IIvera",
      kind: "external",
      url: `https://apple2ts.com/?theme=dark&slot2=vera&tab=vera#${iiveraUrl}`,
      source: "TimePilot-IIvera",
      runtime: "a2vera / Apple II + VERA",
    },
    {
      id: "iigs",
      title: "TimePilot-IIgs",
      kind: "external",
      url: "https://a2gsemu-ia.pages.dev/?lang=en&core=gs2&game=https%3A%2F%2Fgithub.com%2FStewBC%2FTime-Pilot",
      source: "TimePilot-IIgs",
      runtime: "a2gsemu / Apple IIgs",
    },
    {
      id: "mac68k",
      title: "TimePilot-Mac68k",
      path: "mac/",
      kind: "emulated",
      source: "TimePilot-Mac68k",
      runtime: "Infinite Mac / Basilisk II, System 7.5, 8 MB RAM, 640x480",
      note: "Hosts Time.Pilot-m68k.dsk as a second disk; the game starts from the TimePilot icon on the desktop",
    },
    {
      id: "archie",
      title: "TimePilot-Archie",
      path: "archie/",
      kind: "emulated",
      source: "TimePilot-Archie",
      runtime: "Archimedes Live / Arculator, Acorn A3020, ARM250 @ 12 MHz, 4 MB RAM",
      note: "Hosts TimePilot-RISCOS-HostFS.zip; Archimedes Live unpacks it onto HostFS and autoboots !TimePilot",
    },
  ],
};
writeFileSync(join(outDir, "players.json"), JSON.stringify(players, null, 2) + "\n");

// A small sanity report for local runs and CI logs.
function total(dir) {
  let bytes = 0;
  for (const entry of readdirRecursive(dir)) bytes += statSync(entry).size;
  return bytes;
}
function* readdirRecursive(dir) {
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    const path = join(dir, entry.name);
    if (entry.isDirectory()) yield* readdirRecursive(path);
    else if (entry.isFile()) yield path;
  }
}

console.log(`Site assembled: ${outDir}`);
console.log(`  wasm/  ${(total(wasmOut) / 1048576).toFixed(1)} MiB`);
console.log(`  x16/   ${(total(x16Out) / 1048576).toFixed(1)} MiB  (${x16Files.length} files)`);
console.log(`  mac/   ${(total(macOut) / 1048576).toFixed(1)} MiB  (Infinite Mac player + disk)`);
console.log(`  archie/${(total(archieOut) / 1048576).toFixed(1)} MiB  (Archimedes Live player + archive)`);
console.log(`  index.html + assets + players.json`);
