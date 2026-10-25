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
- **Machine listening** (Studio, German): a speech recogniser and the aligner listen to every
  line and mark the words worth a listen, so you can check a language you don't speak.
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
| Machine listening: marks words to listen to (German) | | Yes |

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

## Terms

PlainVoice is proprietary software: see [LICENSE](LICENSE). The third-party software and model
weights it uses, and their licences, are in [NOTICE.md](NOTICE.md). Changes are in the
[changelog](CHANGELOG.md).

Website: https://plainvoice.github.io
