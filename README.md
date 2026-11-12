<p align="center"><img src="logo.png" width="96" alt="PlainVoice logo"></p>

# PlainVoice

**Narration for AI-made videos. Unlimited, offline, with word timing your agent can use.**

PlainVoice is a text-to-speech app for macOS on Apple silicon. It voices scripts, documents and
whole books on your Mac's CPU, with no account, no per-character bill and no telemetry. People
use the window; AI agents use the same engine through MCP and a command line.

This repository is PlainVoice's release channel: the downloads, the guide, the changelog and
the terms. It holds no source code.

## Download

Get the DMG from the [latest release](https://github.com/plainvoice/plainvoice/releases/latest).
It needs macOS 14 or later on an Apple silicon Mac. Version 1.0 is not notarised by Apple yet, so
the first open takes one extra step: see [Install](guide/install.md).

## What it does

- **Unlimited synthesis, offline, on the CPU.** After the models are downloaded, nothing on the
  synthesis path touches the network.
- **Long jobs that survive anything.** A whole book runs in the background and resumes after a
  quit, a crash or sleep. Import TXT, Markdown or EPUB, and export chapters.
- **Word timing on every line**, as SRT, VTT and `words.json`, so video tools and agents can
  place captions and cuts.
- **Bad takes caught for you.** An aligner checks each line for skipped or invented words and
  re-rolls the line that fails.
- **Agents are first-class.** Every operation is an MCP tool and a CLI command. Jobs an agent
  starts show up live in the window, where you can fix one line and re-voice only that line.
- **Pronunciation under your control:** `[word](respelling)`, `[word](/phonemes/)` and
  `[pause:600ms]` right in the script, plus project and global dictionaries.
- **Vietnamese done properly:** 23 voices from the North, Centre and South, with English words
  mixed in.
- **German, down to Grimm's 1857 spelling** (Studio): four voices, with old spelling read as
  today's and kept as written in the captions.
- **Spanish, Latin American** (Studio): four voices, Lucía, Sofía, Mateo and Diego, with
  Quiroga's 1918 spelling (*fué*, *dió*) read as today's and kept as written in the captions.
- **French, from France** (Studio): four voices, Camille, Juliette, Louis and Hugo, with
  numbers, dates, money and Roman numerals (*Louis XIV*, *XIXe siècle*) read out in French.
- **Italian, from Italy** (Studio): four voices, Marco, Luca, Giulia and Chiara, with numbers,
  dates, money and Roman numerals (*Vittorio Emanuele II*, *XIX secolo*) read out in Italian, and
  Collodi's 1883 spelling (*perchè*, *po’*) read as written.
- **Machine listening** (Studio, every voice language): a speech recogniser and the
  aligner listen to every line and mark the words worth a listen, so you can check a language you
  don't speak.
- **Exports** as WAV (48 kHz mono 16-bit), FLAC, M4A and M4B audiobooks with chapters. Every
  audio export is marked as AI-generated speech in its metadata.

## Free and Studio

| | Free | Studio |
|---|---|---|
| Kokoro English voices (28, US and UK) | Yes | Yes |
| VieNeu Vietnamese voices (23) | Yes | Yes |
| Unlimited synthesis, long jobs, all exports, word timing, quality check, MCP and CLI | Yes | Yes |
| Chatterbox Turbo English voices (8) with expression tags such as `[laugh]` | | Yes |
| Voice cloning with consent (Vietnamese and English) | | Yes |
| Chatterbox Multilingual German voices (4) | | Yes |
| Chatterbox Multilingual Spanish voices (4, Latin American) | | Yes |
| Chatterbox Multilingual French voices (4, France) | | Yes |
| Chatterbox Multilingual Italian voices (4, Italy) | | Yes |
| Machine listening: marks words to listen to (every voice language) | | Yes |

Studio is included with a PlainTake licence: one purchase, both apps. See [Studio](guide/studio.md).

## Samples

The same paragraph in four free voices (M4A):

- [Kokoro `af_heart`, US English](samples/kokoro-af_heart.m4a)
- [Kokoro `bf_emma`, UK English](samples/kokoro-bf_emma.m4a)
- [VieNeu Minh Quân, Northern Vietnamese](samples/vieneu-minh-quan.m4a)
- [VieNeu Thùy Dung, Southern Vietnamese](samples/vieneu-thuy-dung.m4a)

## Guide

1. [Install](guide/install.md): the first open, the checksum, the command line.
2. [Your first job](guide/first-job.md): download a model, voice a script, find the files.
3. [Agents](guide/agents.md): Claude Code, Codex, the plugin, the MCP tools and the CLI.
4. [Script markup](guide/markup.md): respellings, phonemes, pauses and expression tags.
5. [Voices and models](guide/voices.md): every voice and model pack.
6. [Studio](guide/studio.md): what it adds and how to activate it.
7. [FAQ](guide/faq.md).

## Claude Code plugin

This repository is also a Claude Code plugin marketplace:

```
/plugin marketplace add plainvoice/plainvoice
/plugin install plainvoice
```

The plugin needs the app installed and `plainvoice` on your `PATH`. See [Agents](guide/agents.md).

## Scanned books to audiobooks

A scanned book is pictures of pages, so it has to be read into text before PlainVoice can voice
it. [`tools/scan-ocr.swift`](tools/scan-ocr.swift) does the reading with the text recogniser
built into macOS: offline, with nothing to install but Apple's command line tools
(`xcode-select --install`). The clean-up between the raw reading and a book worth hearing is
work for an AI agent. Give your agent this section, and a book you have the right to convert.

### Instructions for agents

Work in a folder of its own beside the book. Keep every step's output, so a later step can be
redone without the earlier ones.

1. **Read the pages.** `--languages` lists the codes this macOS reads (Vietnamese is `vi-VT`).

   ```sh
   swiftc -O -o scan-ocr scan-ocr.swift
   ./scan-ocr book.pdf pages --lang vi-VT
   ./scan-ocr book.pdf pages-raw --lang vi-VT --raw --no-images
   ```

   The input is a PDF, a folder of page images, or one image. Each page gives `NNNN.txt` (the
   lines, with a blank line between blocks), `NNNN.json` (every line with its box and a
   confidence from 0 to 1) and `NNNN.jpg` (the page). A run that stops picks up where it
   stopped. The second run reads without language correction: where the two readings of a line
   differ, one of them is wrong.

2. **Learn the book's shape before editing.** Find the contents pages and take the parts and
   chapters from them. Note what repeats on every page (running heads, page numbers) and what
   is not prose (figures, captions, tables, footnotes, boxes).

3. **Write one Markdown file, `book.md`.** Do it with a script that builds the file from
   `pages/`, plus a list of corrections, so the result can be rebuilt. Never retype the book by
   hand.
   - `# Title` once, at the top. `##` for each thing the listener should be able to jump to: the
     foreword, each part, each chapter. `###` and deeper for sections inside a chapter.
   - Join the lines of a paragraph, and a paragraph that runs over a page break. Join a word
     hyphenated at a line end.
   - Drop running heads, page numbers, the contents pages, the index and picture credits.
   - Turn each table and list into sentences that make sense by ear. Say what a figure shows
     in a sentence, or drop it. Put a footnote in its sentence, or drop it.
   - Write out what the voice would stumble on: units, ranges, fractions and abbreviations.
     `plainvoice lint` finds most of them.

4. **Proofread against the page images.** Look first at the lines with low confidence, the lines
   where the two readings differ, and every number, name and dose. Open the page's `.jpg` and
   read it; do not guess from the text alone. Vietnamese tone marks and similar letters
   (`l`/`I`/`1`, `o`/`0`, `rn`/`m`) are the usual errors. Split the pages among subagents for a
   long book, and have each return corrections, not rewritten text. List what you could not
   settle and tell the person.

5. **Lint.** `plainvoice lint book.md --language vi --voice vieneu:truc-ly`. Fix every error,
   and the warnings that matter.

6. **Agree on the voice with one chapter.** `plainvoice voices` lists them. The `# Title`
   line is chapter 1 on its own, so the first `##` is chapter 2.

   ```sh
   plainvoice synth --file "$PWD/book.md" --voice vieneu:truc-ly --chapters 2 \
     --formats m4a --out "$PWD/sample" --wait
   ```

   Play it to the person and wait for a yes before the whole book.

7. **Voice the book.** Leave out `--chapters`; `m4b` is one audiobook file with chapter marks.

   ```sh
   plainvoice synth --file "$PWD/book.md" --voice vieneu:truc-ly \
     --formats m4b --out "$PWD/book" --detach
   plainvoice job <jobId> --wait
   ```

   A book takes hours. The job runs in the engine, not in your shell: it survives a quit or
   sleep and `plainvoice job <jobId> --resume` picks it up. Do not start it again, because each
   `synth --file` makes a new project and voices every line from the start.

8. **Fix lines, not the book.** When the job is done it lists the lines it flagged. Fix one with
   `plainvoice revoice <projectPath> <lineId>` (add `--text` for a text error); the M4B is
   exported again. Report the flagged lines you did not fix.

Good to know:

- A `#` or `##` heading starts a chapter and names its chapter mark. It is not read aloud. If
  the listener should hear it, repeat it as the first line under the heading.
- `--out` must be inside the workspace or a folder the person allowed. On `path.not_allowed`,
  ask them to run `plainvoice roots add <dir>`.
- PlainVoice also imports EPUB. If the person wants an e-book as well, build it from the same
  file with `pandoc book.md -o book.epub --toc --toc-depth=2 --split-level=2` and voice either.
- The rest of the command line and the MCP tools are in [Agents](guide/agents.md).

## Terms

PlainVoice is proprietary software: see [LICENSE](LICENSE). The third-party software and model
weights it uses, and their licences, are in [NOTICE.md](NOTICE.md). Changes are in the
[changelog](CHANGELOG.md).

Website: https://plainvoice.github.io
