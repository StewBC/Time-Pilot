//-----------------------------------------------------------------------------
// Assemble the Commander X16 browser player for the GitHub Pages site.
//
//   import { assembleX16 } from "./TimePilot-CX16/web/assemble.mjs";
//   await assembleX16("web/_site/x16");
//
// The emulator is the official X16Community WebAssembly release r49, downloaded
// once into an external cache and checksum-verified.  Nothing from the emulator
// is committed to this repository.  Game files come from the llvm-mos build in
// TimePilot-CX16/web/dist and the flat HostFS assets in web/assets.
//-----------------------------------------------------------------------------

import { createHash } from "node:crypto";
import {
  existsSync, mkdirSync, readFileSync, readdirSync, statSync, writeFileSync,
} from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { inflateRawSync } from "node:zlib";

const here = dirname(fileURLToPath(import.meta.url));
const port = resolve(here, "..");
const repo = resolve(port, "..");

export const EMULATOR_ARCHIVE = "x16emu_wasm-r49.zip";
export const EMULATOR_URL =
  "https://github.com/X16Community/x16-emulator/releases/download/r49/" + EMULATOR_ARCHIVE;
export const EMULATOR_SHA256 =
  "9711036cf5b33504815b278fa872b8ec20aef9cb609fd7b17f3685d91312628f";

const EMULATOR_FILES = ["x16emu.js", "x16emu.wasm", "x16emu.data"];

// TimePilot-CX16/src/data.c loads these through KERNAL LOAD.  The web build
// uses TP_CX16_ASSET_PREFIX="" so they sit at the HostFS drive root.
export const GAME_FILES = ["time_pilot.prg", "tpspr.vrm", "tpfont.vrm",
  ...Array.from({ length: 43 }, (_, index) => `bank${String(index + 1).padStart(3, "0")}.au`)];

function readZip(buffer) {
  let eocd = -1;
  const lowest = Math.max(0, buffer.length - 22 - 0xffff);
  for (let i = buffer.length - 22; i >= lowest; --i) {
    if (buffer.readUInt32LE(i) === 0x06054b50) { eocd = i; break; }
  }
  if (eocd < 0) throw new Error("not a ZIP archive (no end-of-central-directory record)");

  const entries = buffer.readUInt16LE(eocd + 10);
  const start = buffer.readUInt32LE(eocd + 16);
  const files = new Map();
  let cursor = start;
  for (let i = 0; i < entries; ++i) {
    if (buffer.readUInt32LE(cursor) !== 0x02014b50) throw new Error("corrupt central directory");
    const method = buffer.readUInt16LE(cursor + 10);
    const compressedSize = buffer.readUInt32LE(cursor + 20);
    const nameLength = buffer.readUInt16LE(cursor + 28);
    const extraLength = buffer.readUInt16LE(cursor + 30);
    const commentLength = buffer.readUInt16LE(cursor + 32);
    const localOffset = buffer.readUInt32LE(cursor + 42);
    const name = buffer.toString("utf8", cursor + 46, cursor + 46 + nameLength);
    const dataStart = localOffset + 30
      + buffer.readUInt16LE(localOffset + 26)
      + buffer.readUInt16LE(localOffset + 28);
    const raw = buffer.subarray(dataStart, dataStart + compressedSize);
    files.set(name, method === 0 ? Buffer.from(raw) : inflateRawSync(raw));
    cursor += 46 + nameLength + extraLength + commentLength;
  }
  return files;
}

function sha256(buffer) {
  return createHash("sha256").update(buffer).digest("hex");
}

async function fetchWithRetry(url, attempts = 5) {
  let lastError;
  for (let attempt = 1; attempt <= attempts; attempt++) {
    try {
      const response = await fetch(url, {
        redirect: "follow",
        signal: AbortSignal.timeout(180000),
      });
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      return response;
    } catch (problem) {
      lastError = problem;
      if (attempt === attempts) break;
      console.log(`  download attempt ${attempt} failed (${problem.message}); retrying`);
      await new Promise((resolve) => setTimeout(resolve, 3000));
    }
  }
  throw lastError;
}

export async function emulatorArchive(cacheDir) {
  mkdirSync(cacheDir, { recursive: true });
  const archivePath = join(cacheDir, EMULATOR_ARCHIVE);
  if (existsSync(archivePath) && sha256(readFileSync(archivePath)) === EMULATOR_SHA256) {
    return readFileSync(archivePath);
  }
  console.log(`  downloading ${EMULATOR_URL}`);
  let response;
  try {
    response = await fetchWithRetry(EMULATOR_URL);
  } catch (problem) {
    throw new Error(`cannot download ${EMULATOR_URL}: ${problem.message}\n` +
      `for an offline build put the archive at ${archivePath}`);
  }
  const bytes = Buffer.from(await response.arrayBuffer());
  if (sha256(bytes) !== EMULATOR_SHA256) {
    throw new Error(`emulator archive checksum mismatch (${sha256(bytes)})`);
  }
  writeFileSync(archivePath, bytes);
  return bytes;
}

/** Copy the emulator, game files and player shell into `outDir`. */
export async function assembleX16(outDir, options = {}) {
  const cacheDir = options.cacheDir || join(here, ".cache");
  const distDir = options.distDir || join(here, "dist");
  const assetsDir = options.assetsDir || join(here, "assets");
  const zip = readZip(await emulatorArchive(cacheDir));

  const written = [];
  const emulatorDir = join(outDir, "emulator");
  mkdirSync(emulatorDir, { recursive: true });
  for (const name of EMULATOR_FILES) {
    const bytes = zip.get(name);
    if (!bytes) throw new Error(`${EMULATOR_ARCHIVE} does not contain ${name}`);
    writeFileSync(join(emulatorDir, name), bytes);
    written.push([`emulator/${name}`, bytes.length]);
  }

  const gameDir = join(outDir, "game");
  mkdirSync(gameDir, { recursive: true });
  const resources = [];
  for (const name of GAME_FILES) {
    const source = name === "time_pilot.prg"
      ? join(distDir, name)
      : join(assetsDir, name);
    if (!existsSync(source)) {
      throw new Error(`missing game file ${source} — run TimePilot-CX16/web/build first`);
    }
    const lower = name.toLowerCase();
    writeFileSync(join(gameDir, lower), readFileSync(source));
    resources.push(lower);
    written.push([`game/${lower}`, statSync(source).size]);
  }
  const manifest = JSON.stringify({ resources, prg: "time_pilot.prg" }, null, 2) + "\n";
  writeFileSync(join(gameDir, "manifest.json"), manifest);
  written.push(["game/manifest.json", Buffer.byteLength(manifest)]);

  // Player shell and its title art.
  for (const name of ["index.html", "app.js", "style.css"]) {
    const source = join(here, name);
    if (existsSync(source)) {
      writeFileSync(join(outDir, name), readFileSync(source));
      written.push([name, statSync(source).size]);
    }
  }
  const artDir = join(outDir, "assets");
  mkdirSync(artDir, { recursive: true });
  for (const [source, name] of [
    [join(repo, "TimePilot-16bit-C", "sprites", "logo.png"), "timepilot-logo.png"],
    [join(repo, "TimePilot-IIgs", "png", "splash.png"), "timepilot-splash.png"],
    [join(repo, "web", "assets", "favicon.png"), "favicon.png"],
    [join(repo, "web", "assets", "favicon-180.png"), "favicon-180.png"],
    [join(repo, "web", "assets", "favicon.ico"), "favicon.ico"],
  ]) {
    if (existsSync(source)) {
      writeFileSync(join(artDir, name), readFileSync(source));
      written.push([`assets/${name}`, statSync(source).size]);
    }
  }

  return written;
}

// Direct invocation: node TimePilot-CX16/web/assemble.mjs [outDir]
if (import.meta.url === `file://${process.argv[1]}` || process.argv[1]?.endsWith("assemble.mjs")) {
  const out = process.argv[2] || repo + "/web/_site/x16";
  const written = await assembleX16(out);
  console.log(`Assembled ${out}`);
  for (const [name, size] of written) console.log(`  ${name}  ${size} bytes`);
}
