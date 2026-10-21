---
name: plainvoice
description: Use when narrating a script, video or document with PlainVoice, the offline text-to-speech app. Covers linting a script, voicing it, fixing single lines, and using word timings for captions and cuts.
---

# Narrating with PlainVoice

PlainVoice voices text on this machine, offline. Every line gets word timing. You drive it with
the MCP tools below. Outputs are file paths on disk, never audio bytes. Read the files you need.

## The loop

1. `list_voices` to pick a voice. Use `kokoro:<voice>` (for example `kokoro:af_heart`) or, for
   the most natural English narration, `chatterbox:pilot_heart` (PlainVoice Studio: without a
   licence it fails with `license.pro_required`; tell the person, or use Kokoro). If its model
   is not installed, `list_models`, then `install_model` (the only tool that uses the network; ask the person
   first) and follow its `jobId` with `get_job`.
2. `lint_script` with the text and the language. Pass `format: "markdown"` for Markdown. Pass `voice` so lint checks
   that engine's markup (phoneme markers are Kokoro-only). Fix every
   error. Fix the warnings that matter (numbers, acronyms, unknown words, long sentences).
   Each issue has a line and column.
3. `synthesize` with the `voice` and exactly one of `text`, `file` or `steps`. It returns a
   `jobId` and a `projectPath`. Keep both.
4. `get_job` with `waitSeconds: 50`. If the state is still `queued` or `running`, call it again.
   Stop when it is `done`, `failed` or `cancelled`. `cancel_job` stops a job.
5. Read the job's lists:
   - `flaggedLines`: lines that were voiced and exported, but the quality gate still flags the
     take (a dropped word, odd timing). Fix each with `revoice_line`.
   - `failedLines`: lines that could not be voiced and are left out of the export. Fix the text
     (see the lint issues), then `revoice_line` with the new `text`.
   Both lists cover only the lines that job voiced.
6. `revoice_line` with `projectPath` and `lineId`. Give a new `text`, `voice` or `seed`. With none
   of them it re-rolls the line with seeds it was not voiced with. It returns a new `jobId`: follow
   it with `get_job`. When it is done, the project is exported again to the same files and
   chapters (failed lines left out). The exception: if another job of the project is still
   queued, running or paused, the revoice job has no `outputs`, and that job's export has the new
   line. A steps project re-exports only the line's step.
7. Use the outputs. The WAV is the master (48 kHz mono 16-bit). SRT and VTT are ready-made
   captions. `words.json`, for captions and cuts, is
   `{version, sampleRate, durationMs, engine, lines: [{id, text, voice, startMs, endMs, words: [{text, startMs, endMs}]}]}`.
   Every `startMs` and `endMs` is milliseconds from the start of the WAV; a word's `text` is as
   written. (A steps project's per-step file is different: see Steps files.)

`synthesize` options: `speed` (0.5 to 2), `language`, `chapters` (1-based), `formats` (any of
`wav`, `flac`, `m4a`, `m4b`, `srt`, `vtt`, `words`; `words` is `words.json`), `out` (an absolute path).

## Markers

Put these in the script text. Lint reports a malformed one as `markup.invalid` with its line and
column.

- Respelling: `Say [Siobhan](shivawn) first.` Speaks "shivawn". Captions and `words.json` keep
  "Siobhan". Use letters, spaces, apostrophes and hyphens only.
- Phonemes: `[Kokoro](/kˈOkəɹO/)` speaks raw phonemes. Kokoro only. For other voices lint
  gives `markup.unsupported`.
- Pause: `First point. [pause:600ms] Second point.` A length is 50 to 5000 ms of silence before
  the next line. A bare `[pause]` only breaks the line.

Rules:
- An inline marker beats the project dictionary, which beats the global one.
- An inline marker also reaches a later plain occurrence of the same word in the same line. Split
  the line to avoid that.
- Expression tags work on Chatterbox voices only: `[angry]` `[fear]` `[surprised]` `[whispering]`
  `[advertisement]` `[dramatic]` `[narration]` `[crying]` `[happy]` `[sarcastic]`
  `[clear throat]` `[sigh]` `[shush]` `[cough]` `[groan]` `[sniff]` `[gasp]` `[chuckle]` `[laugh]`.
  Example: `Oh, that's hilarious! [chuckle] Um, anyway.` Case does not matter. A tag is acted, not
  read: it never shows in captions or `words.json`.
- Any other `[tag]`, and every tag for a Kokoro or VieNeu voice, is stripped (lint warns
  `markup.tag_ignored`).
- To fix a word for good, call `set_pronunciation` (`scope: "project"` with `projectPath`, or
  `"global"`). It applies to lines voiced from now on, so `revoice_line` the lines already voiced.

## Allowed roots

Files are written only inside the workspace and the folders the person has allowed. If a tool
returns `path.not_allowed`, do not try another path. Ask the person to add the folder with
`plainvoice roots add <dir>`, then retry.

## Seeds

Kokoro ignores the seed, so a re-roll there is identical. Do not loop on it: change the text, add
a respelling or pause, or change the voice. Chatterbox re-rolls differ. The quality gate already
tried three seeds for each line, so `revoice_line` with no changes moves past them.

## Steps files (PlainTake)

For per-step clips, pass `steps` (an absolute path to `[{stepId, text}]`), `layout: "plaintake"`
and `out` (a folder) to `synthesize`. It writes `<out>/<stepId>.wav` and `<stepId>.words.json`
(`[{word, startMs, endMs}]`, from the clip's start) for each step at 24 kHz. A re-run voices only
the steps whose text changed. `revoice_line` on such a project fixes one step now, but the next run
restores the steps file's text, voice and seed, so edit the steps file too. A voice-only or
seed-only revoice cannot be kept that way. See the recipes in
https://github.com/plainvoice/plainvoice/blob/main/guide/agents.md.

## CLI twins

Each tool has a command with the same name in meaning:

- `plainvoice voices` lists voices, and `plainvoice models` lists model packs.
- `plainvoice install <id>` installs a model pack.
- `plainvoice lint <file>` lints a script.
- `plainvoice synth --voice <v> --text|--file|--steps ... --out <path> --wait` voices it.
- `plainvoice job <id> --wait` follows a job, and `plainvoice cancel <id>` cancels it.
- `plainvoice revoice <project> <lineId>` revoices a line.
- `plainvoice say <word> <respelling>` sets a pronunciation.
- `plainvoice roots` lists, adds and removes allowed folders.
