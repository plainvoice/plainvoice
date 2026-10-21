# FAQ

## Does PlainVoice need the internet?

Only for three things, and only when you ask:

- downloading a model pack;
- activating a Studio licence (one check with Gumroad);
- **Check for updates** in Settings, or `plainvoice check-updates`, which reads this repository's
  releases on GitHub.

Nothing else opens a network connection: voicing, exporting and MCP stay on your Mac. PlainVoice
has no account, no telemetry and no automatic update check.

## Which Macs does it run on?

macOS 14 or later on Apple silicon (M1 or newer). There is no Intel build. Voicing runs on the
CPU; there is no GPU mode in 1.0.

## Windows? Linux?

Windows is planned for a later 1.x release. Linux is not planned.

## Which languages?

English (US and UK) and Vietnamese, including Vietnamese with English words mixed in. The app's
interface is in English.

## Can I use the audio commercially?

Yes. The audio you make is yours to use in videos, audiobooks, courses and ads, on the Free tier
and in Studio, as long as you have the rights to the text and, for a cloned voice, the speaker's
permission. See [LICENSE](../LICENSE).

## Is the audio marked as AI-generated?

Yes. Every audio export (WAV, FLAC, M4A, M4B) carries a metadata tag saying it is AI-generated
speech made with PlainVoice. It is metadata, not an audible watermark, and re-encoding the file
may remove it. Captions and `words.json` are not marked.

## Why does macOS warn me the first time I open it?

Version 1.0 is signed ad hoc and not notarised by Apple yet. Check the download against
`SHA256SUMS`, then follow the steps in [Install](install.md#3-the-first-open). Notarisation will come
in a later release.

## Is the same text always voiced the same way?

On the same Mac, yes: the same text, voice, seed, model and PlainVoice version give a
byte-identical WAV. Each line records its seed, so a take can be reproduced. A re-roll uses a new
seed (Chatterbox and VieNeu give a new take; Kokoro gives the same one).

## Which export formats are there?

WAV (48 kHz mono 16-bit, the master), FLAC, M4A, M4B with chapters, SRT, VTT and `words.json`.
There is no MP3 export in 1.0.

## Where are my files?

- Projects and their exports: your workspace, `~/Documents/PlainVoice` unless you changed it in
  Settings.
- Models, the licence, settings and the engine's socket:
  `~/Library/Application Support/PlainVoice`.

## What is the engine?

A background process that owns the models, the job queue and the CPU. The app, the CLI and MCP
all talk to it over a private socket that only your macOS user can open; there is no network
listener. It starts when one of them needs it and quits on its own after a while idle with no
jobs.

## Can an agent write anywhere on my Mac?

No. Agents write only inside the workspace and the folders you allow in Settings (or with
`plainvoice roots add <dir>`). Anything else is refused with `path.not_allowed`.

## Does Studio expire?

No. Studio is perpetual: you buy once, activate once, and keep it. See [Studio](studio.md).

## Which third-party models and software does PlainVoice use?

They are all listed with their licences in [NOTICE.md](../NOTICE.md). None is GPL, AGPL or
licensed for non-commercial use only.
