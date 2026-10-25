# Third-party notices

PlainVoice uses the third-party software and model weights below. Each is used under its own
licence, listed here. Nothing licensed under the GPL or the AGPL is included, and no model weights
are under a non-commercial licence.

## Model packs

The app downloads these packs when you ask for them, from the URLs in their manifests, and checks
every file against its published SHA-256. Each heading is the pack's title as **Models** shows it.

### Kokoro 82M English (`kokoro-82m-en`)

- **Kokoro-82M** (Apache-2.0), copyright hexgrad. English synthesis and its 28 voices. The ONNX
  export with timestamps is published by `onnx-community`.
  https://huggingface.co/hexgrad/Kokoro-82M
- **misaki** lexicon data `us_gold`, `us_silver`, `gb_gold`, `gb_silver` (Apache-2.0), copyright
  hexgrad. https://github.com/hexgrad/misaki
- **HeadTTS** English dictionary `en-us.txt` (MIT), copyright 2025 Mika Suominen.
  https://github.com/met4citizen/HeadTTS
- **CMU Pronouncing Dictionary** (BSD-2-Clause), copyright Carnegie Mellon University. It is the
  source of the HeadTTS dictionary.

### VieNeu v3 Turbo Vietnamese (fp32) (`vieneu-v3-turbo-vi`)

- **VieNeu-TTS v3 Turbo** (Apache-2.0), copyright pnnbao. Vietnamese synthesis and its 23 preset
  voices, under the author's commercial grant and consent statement.
  https://huggingface.co/pnnbao-ump/VieNeu-TTS-v3-Turbo
- **MOSS-Audio-Tokenizer-Nano** (Apache-2.0), copyright OpenMOSS. The audio codec VieNeu decodes
  with. https://huggingface.co/OpenMOSS-Team/MOSS-Audio-Tokenizer-Nano
- **sea-g2p** dictionary `sea_g2p.bin` (Apache-2.0), copyright pnnbao97. Vietnamese and English
  pronunciations. https://github.com/pnnbao97/sea-g2p
- The **vieneu** 3.7.1 Python package (Apache-2.0), copyright pnnbao, is downloaded for its voice
  table only. No Python runs.

### VieNeu voice-clone encoders (`vieneu-clone-vi`)

- The **VieNeu-TTS v3 Turbo** speaker encoder (Apache-2.0), copyright pnnbao, and the
  **MOSS-Audio-Tokenizer-Nano** encoder (Apache-2.0), copyright OpenMOSS. They turn a reference
  clip into a cloned Vietnamese voice.

### Chatterbox Turbo English (`chatterbox-turbo-en`)

- **Chatterbox Turbo** (MIT), copyright Resemble AI. English synthesis and its expression tags.
  https://huggingface.co/ResembleAI/chatterbox-turbo-ONNX
  Its decoder graph is patched by us to take a seed, so a take can be reproduced; the weights are
  unchanged.
- The **8 built-in voices** are conditioned on synthetic reference clips spoken by the Kokoro
  voices `af_heart`, `af_bella`, `am_michael`, `am_fenrir`, `bf_emma`, `bf_isabella`, `bm_george`
  and `bm_fable` (Apache-2.0). No real person's voice is behind them.

### Chatterbox Multilingual German (`chatterbox-multilingual-de`)

- **Chatterbox Multilingual** (MIT), copyright Resemble AI, in the ONNX export by
  `onnx-community`. German synthesis.
  https://huggingface.co/onnx-community/chatterbox-multilingual-ONNX
  Its decoder graph is patched by us to take a seed, so a take can be reproduced; the weights are
  unchanged.
- The **4 built-in German voices** are conditioned on synthetic German clips that Chatterbox
  Multilingual itself speaks. It speaks them in voices first conditioned on clips of the Kokoro
  voices `af_heart`, `bf_emma`, `am_michael` and `bm_george` (Apache-2.0). No real person's voice
  is behind them.

### Chatterbox voice cloning (English) (`chatterbox-clone-en`)

- The **Chatterbox Turbo** speech encoder (MIT), copyright Resemble AI, exported to ONNX by us. It
  turns a reference clip into a cloned English voice.

### wav2vec2 base 960h English aligner (`wav2vec2-base-960h-en`)

- **wav2vec2-base-960h** (Apache-2.0), copyright Facebook AI: `facebook/wav2vec2-base-960h`,
  exported to ONNX by us. The English aligner. https://huggingface.co/facebook/wav2vec2-base-960h

### wav2vec2 XLSR-53 Vietnamese aligner (int8) (`wav2vec2-xlsr53-vi`)

- **wav2vec2-large-xlsr-53-vietnamese** (Apache-2.0 on the model card):
  `not-tanh/wav2vec2-large-xlsr-53-vietnamese`, exported to ONNX by
  `XDcobra/wav2vec2-large-xlsr-53-vietnamese-ONNX`. The Vietnamese aligner. Its training data
  includes VIVOS (CC BY-NC-SA 4.0); the weights themselves are published under Apache-2.0.
  https://huggingface.co/XDcobra/wav2vec2-large-xlsr-53-vietnamese-ONNX

### wav2vec2 XLSR-53 German aligner (int8) (`wav2vec2-xlsr53-de`)

- **wav2vec2-large-xlsr-53-german-cv13** (Apache-2.0 on the model card), by Oliver Guhr:
  `oliverguhr/wav2vec2-large-xlsr-53-german-cv13`, fine-tuned on Common Voice 13 (CC0), exported
  to ONNX and quantised to int8 by us. The German aligner.
  https://huggingface.co/oliverguhr/wav2vec2-large-xlsr-53-german-cv13

### Whisper large-v3-turbo machine listening (int8) (`whisper-large-v3-turbo`)

- **Whisper large-v3-turbo** (MIT), copyright OpenAI: `openai/whisper-large-v3-turbo`,
  exported to ONNX and quantised to int8 by us. It listens to voiced lines when you turn on
  machine listening. https://huggingface.co/openai/whisper-large-v3-turbo

### ONNX Runtime 1.24.3 (`onnxruntime-1.24.3`)

- **ONNX Runtime** (MIT), copyright Microsoft Corporation. The engine every model runs on.
  https://github.com/microsoft/onnxruntime

## Built into the app

- **sea-g2p** 0.10.0 (Apache-2.0), copyright pnnbao97. Vietnamese and English text normalisation
  and grapheme-to-phoneme, compiled into the engine. https://github.com/pnnbao97/sea-g2p
- **NRL Report 7948** letter-to-sound rules (public domain). Elovitz et al., Naval Research
  Laboratory, 1976.
- **zip** (MIT), copyright Mathijs van de Nes and contributors. EPUB reading.
- **quick-xml** (MIT), copyright Johann Tuffe and contributors. EPUB OPF, nav and NCX parsing.
- **getrandom** (MIT OR Apache-2.0), copyright The Rand Project Developers. Job and project ids.
- **libc** (MIT OR Apache-2.0), copyright The Rust Project Developers. Process, file-lock and
  socket calls on Unix.
- **hmac** and **sha2** (MIT OR Apache-2.0), copyright The RustCrypto Project Developers. Model
  checksums and the licence file's signature.
- **Tauri** (MIT OR Apache-2.0), copyright The Tauri Programme within The Commons Conservancy. The
  app's window.
- **React** (MIT), copyright Meta Platforms, Inc. and affiliates, and **i18next** (MIT), copyright
  i18next. The app's interface and its strings.

### The Rust crates and JavaScript packages

The engine, the `plainvoice` command and the app are built from open-source Rust crates, and the
app's window from JavaScript packages. Every one of them is used under one of these licences:
MIT, Apache-2.0 (with or without the LLVM exception), BSD-2-Clause, BSD-3-Clause, ISC,
Unicode-3.0, Unicode-DFS-2016, Zlib, MPL-2.0 or, for JavaScript packages, 0BSD. Where a crate offers a choice of licences, it is
used under one of these. The build refuses any other licence. Each crate's and package's
copyright and licence text is in its own source distribution, on crates.io and npm.

## System components

- **AudioToolbox** (Apple, part of macOS, not redistributed). The AAC encoder for M4A and M4B
  export.
- **curl** (`/usr/bin/curl`, part of macOS, not redistributed). Model downloads, licence
  activation and the update check.
