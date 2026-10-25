# Studio

PlainVoice is free to use without limits: the Kokoro and VieNeu voices, unlimited synthesis, long
jobs, every export format, word timing, the quality check, MCP and the CLI. Studio adds the
studio voices and cloning.

## What Studio adds

- **Chatterbox Turbo**, the most natural English voices in PlainVoice: 8 built-in voices, US and
  UK, with 19 [expression tags](markup.md#expression-tags-chatterbox-voices-studio) such as
  `[laugh]`, `[sigh]` and `[whispering]`.
- **Voice cloning with consent**, on every engine that clones: Vietnamese voices (VieNeu) from 3 to
  8 seconds of speech, and English voices (Chatterbox) from 5 to 10 seconds. See
  [Cloned voices](voices.md#cloned-voices-studio).
- **German** (since 1.3): four Chatterbox Multilingual voices, Greta, Lotte, Jonas and Friedrich.
  Old spelling, as in Grimm's 1857 tales (*daß*, *Thür*, *seyn*), is read as today's German, and
  the captions keep the text as written.
- **Machine listening** (since 1.3, German). It is for checking narration in a language you
  don't speak:
  - a speech recogniser (Whisper, 1.1 GB, installed from **Models**) and the aligner listen to
    each voiced line;
  - a line is marked **Listen:** when both heard a word differently, and **Maybe:** when one
    did;
  - click the mark to see what each one heard.

  Turn it on in the Editor, or press **Check now** for lines already voiced. In the CLI it is
  `plainvoice synth --verify` and `plainvoice verify <project>`; for agents, the MCP tool
  `verify_project`. It is a machine's guess, so play the line before you re-voice it. Nothing
  is re-voiced on its own.

Everything else is the same in Free and Studio. Downloading the Studio model packs is allowed
without a licence; voicing with them is not.

## Buy

**Studio is included with a PlainTake licence: one purchase, both apps.** Buy it at
https://plainlab.gumroad.com/l/plaintake. The key Gumroad sends you unlocks PlainVoice Studio as
well as PlainTake. If you already own PlainTake, you already have Studio: use the same key.

## Activate

In the app: open **Settings → Licence**, paste the key into **Licence key** and click
**Activate**. Settings then shows "Studio" and who it is licensed to.

From the command line, with the key on the clipboard:

```sh
pbpaste | plainvoice licence activate
```

or from a file with `plainvoice licence activate --key-file <path>`. The key is read from stdin or
the file, never from the command line, so it does not show up in your shell history or in the
process list. `plainvoice licence` shows the licence, and `plainvoice licence remove` takes it off
this Mac.

## How the licence works

- **Perpetual.** You buy once and keep Studio: no subscription, no expiry date, no renewal.
- **Offline after one check.** Activating asks Gumroad once whether the key is valid. After that
  PlainVoice never checks again; it reads the signed licence file on your Mac.
- **Nothing else is sent.** The activation sends the key and PlainTake's product id to Gumroad's
  licence API over HTTPS. No scripts, audio, usage data or machine identifier are sent. PlainVoice
  keeps the licence key itself and Gumroad's answer (the purchase email, shown as "Licensed to")
  in `~/Library/Application Support/PlainVoice/licence.json`. The key is stored there in plain
  text, in a file readable only by you (mode `0600`, in your data dir).
- **On your other Macs**, activate with the same key.
- **If activation fails** (no network, a mistyped key), PlainVoice stays as it was: an existing
  licence is kept, and Free features keep working. A refunded or disputed purchase cannot be
  activated.
- **Without a licence**, Chatterbox voices (English and German) and cloned voices refuse to
  voice, and machine listening refuses to listen, with the error `license.pro_required`; Kokoro and VieNeu voices work as before. A cloned voice you made with
  Studio is kept, and works again when you activate.
