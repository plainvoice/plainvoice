# Your first job

This takes a few minutes, most of it the model download. You need the app installed
([Install](install.md)).

## In the app

1. **Models.** Install **ONNX Runtime 1.24.3** and **Kokoro 82M English**. The progress shows in
   the list and in **Queue**. For Vietnamese, install **VieNeu v3 Turbo Vietnamese (fp32)** too.
   [Voices and models](voices.md) says what each pack is for.
2. **Projects → New.** Paste some text, pick the language and a voice (for example Heart,
   `kokoro:af_heart`), choose the formats you want, and click **Start**. PlainVoice checks the
   text first and lists any problems it finds (numbers, acronyms, unknown words, bad markup) with
   their line and column.

   To voice a file instead, choose **Import** and pick a `.txt`, `.md` or `.epub`. A book's
   chapters become the project's chapters.
3. **Queue** shows the job's progress and time left. You can pause, resume or cancel it. You can
   also quit the app: the job carries on in the background engine, and a job cut off by a crash
   or sleep resumes where it stopped.
4. **Editor** shows the project's lines by chapter. Play a line, or play from here; the words
   light up as they are spoken. A line the quality check flagged is marked. Edit its text, change
   its voice (any installed voice, in any language or model), or click **Re-voice** to voice only
   that line again; the project's exports are written again with the new line.

## Where the files are

Projects live in your workspace, `~/Documents/PlainVoice` unless you changed it in Settings. Each
project is a folder:

```
<project>/
  project.json   the title, language, voice, chapters and lines
  source/        the imported file, as it was
  lines/         one audio file and one JSON file per line
  exports/       <project>.wav, .flac, .m4a, .m4b, .srt, .vtt and .words.json
```

Exports are named after the project folder, not the title.

- The WAV is the master: 48 kHz, mono, 16-bit.
- SRT and VTT are ready-made captions.
- `words.json` has every line and every word with its start and end in milliseconds from the
  start of the audio, for captions and cuts in video tools.
- M4B is an audiobook with chapter marks.

## From the command line

The same job with the `plainvoice` command ([Install](install.md#the-command-line) says how to put
it on your `PATH`):

```sh
plainvoice install onnxruntime-1.24.3
plainvoice install kokoro-82m-en
plainvoice lint script.md
plainvoice synth --voice kokoro:af_heart --file script.md --wait
```

`synth` shows progress, then prints the files it wrote. By default it writes WAV, SRT, VTT and
`words.json` to the project's `exports/`. Add `--out ~/Movies/narration.wav` to write them elsewhere, and
`--formats wav,m4a,srt` to pick the formats. `plainvoice job <id> --wait` follows a job, and
`plainvoice revoice <project> <lineId> --text "…"` re-voices one line.

Next: [Agents](agents.md) to let Claude Code or Codex do this for you, and
[Script markup](markup.md) to fix a pronunciation or add a pause.
