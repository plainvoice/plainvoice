# Voices and models

A voice id is `<engine>:<voice>`, for example `kokoro:af_heart`. The **Voices** screen in the app
plays a sample of each and filters by language, region, sex and style; `plainvoice voices` lists
them in a terminal.

PlainVoice speaks English (US and UK) and Vietnamese. Hear some of the voices in the
[samples](../README.md#samples).

## Kokoro: English, free

28 voices, fast on any Apple silicon Mac. Word timing comes straight from the model.

| Accent | Female | Male |
|---|---|---|
| US | `af_heart` (default), `af_bella`, `af_nicole`, `af_alloy`, `af_aoede`, `af_jessica`, `af_kore`, `af_nova`, `af_river`, `af_sarah`, `af_sky` | `am_adam`, `am_echo`, `am_eric`, `am_fenrir`, `am_liam`, `am_michael`, `am_onyx`, `am_puck`, `am_santa` |
| UK | `bf_emma`, `bf_alice`, `bf_isabella`, `bf_lily` | `bm_daniel`, `bm_fable`, `bm_george`, `bm_lewis` |

Kokoro gives the same audio for the same text every time, so re-voicing a line unchanged gives
the same take. To change a take, change the text, add a respelling or a pause, or pick another
voice.

## VieNeu: Vietnamese, free

23 voices from the North, Centre and South, in natural, news and storytelling styles. Vietnamese
text may mix in English words. Word timing comes from the Vietnamese aligner.

| Region | Voices |
|---|---|
| North | `minh-quan` (Minh Quân, default), `minh-duc`, `pham-tuyen`, `xuan-vinh`, `thanh-binh`, `manh-dung`, `anh-khoi`, `truc-ly`, `ngoc-linh`, `doan-trang`, `mai-anh`, `quynh-anh`, `ngoc-huyen` |
| Centre | `quang-son`, `ngoc-tran` |
| South | `thai-son`, `minh-triet`, `duc-tri`, `adam`, `thuc-doan`, `thuy-dung`, `my-duyen`, `kim-thanh` |

Each id is `vieneu:<voice>`, for example `vieneu:thuy-dung`.

## Chatterbox Turbo: English, Studio

The most natural English voices, with [expression tags](markup.md#expression-tags-chatterbox-voices-studio)
such as `[laugh]`. Chatterbox voices a little slower than real time on the CPU, so a long book
takes longer than its running time; Kokoro is much faster. Word timing comes from the English
aligner.

| Accent | Female | Male |
|---|---|---|
| US | `pilot_heart`, `avery` | `miles`, `rowan` |
| UK | `eleanor`, `imogen` | `arthur`, `felix` |

These 8 voices are synthetic: each is conditioned on a clip spoken by a Kokoro voice, so no real
person's voice is behind them. Unlike Kokoro, a Chatterbox re-roll with a new seed gives a
different take.

## Cloned voices, Studio

With Studio you can clone a voice from a clean WAV clip of one speaker, with no music or
background noise:

- Vietnamese (VieNeu): 3 to 8 seconds of speech, with the **VieNeu voice-clone encoders** pack.
- English (Chatterbox): 5 to 10 seconds of speech, with the **Chatterbox voice cloning
  (English)** pack.

You must confirm that you have the speaker's permission and that the clip is theirs. PlainVoice
records that confirmation with the voice and refuses to clone without it. Clone in **Voices →
Clone a voice**, or with `plainvoice voice clone`. Making and using a cloned voice both need
Studio.

## Several voices in one project

Each line in the Editor has a **Line voice** select that lists every installed voice, grouped by
language: **English (US)**, **English (UK)** and **Vietnamese**. Choosing one re-voices that line,
so one project can hold a whole dialogue and **Play all** plays it in one go. The **Project voice**
select still lists only the project's language; it is the default for lines without a voice of
their own, and changing it keeps the lines' own voices.

A line is voiced in its voice's language: its text rules, the global pronunciation dictionary of
that language and the word-timing aligner of that language apply. Without the Vietnamese aligner
pack, that line's word times are estimated and the Editor says so. The project's own
pronunciations apply to every line, whatever its language.

- Project speed moves Kokoro lines only. Chatterbox and VieNeu lines always speak at their own
  pace; the speed control's tooltip says so when the project mixes them.
- [Expression tags](markup.md#expression-tags-chatterbox-voices-studio) such as `[chuckle]` stay in
  the text and only Chatterbox lines act on them. Other lines skip them, and captions never show
  them.
- Chatterbox voices need PlainVoice Studio, on a single line too.
- A line whose voice is missing (a deleted clone, a model not installed) fails alone; the rest of
  the job continues.
- Exports (WAV, FLAC, M4A, M4B, SRT, VTT, `words.json`) mix models at different sample rates; the
  master is 48 kHz as before.

## Model packs

Voices need their model pack installed. Install packs in **Models** or with
`plainvoice install <id>`. Every file is checked against its published SHA-256 before use.
Installing is free for every pack; using a Studio pack's voices needs Studio.

| Pack | Id | For | Tier |
|---|---|---|---|
| ONNX Runtime 1.24.3 | `onnxruntime-1.24.3` | the engine every model runs on; always needed | Free |
| Kokoro 82M English | `kokoro-82m-en` | Kokoro voices | Free |
| VieNeu v3 Turbo Vietnamese (fp32) | `vieneu-v3-turbo-vi` | VieNeu voices | Free |
| wav2vec2 XLSR-53 Vietnamese aligner (int8) | `wav2vec2-xlsr53-vi` | word timing and the quality check for VieNeu | Free |
| wav2vec2 base 960h English aligner | `wav2vec2-base-960h-en` | word timing and the quality check for Chatterbox | Free |
| VieNeu voice-clone encoders | `vieneu-clone-vi` | cloning Vietnamese voices | Free download, cloning is Studio |
| Chatterbox Turbo English | `chatterbox-turbo-en` | Chatterbox voices | Studio |
| Chatterbox voice cloning (English) | `chatterbox-clone-en` | cloning English voices | Studio |

Without its aligner, a VieNeu or Chatterbox line still voices, but its word times are estimated
from the text, and the app labels them so. The licence of every pack is in
[NOTICE.md](../NOTICE.md).
