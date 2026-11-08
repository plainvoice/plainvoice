# Changelog

## 1.6.0 (2026-11-08)

Italian.

- **Italian voices** (Studio): Marco, Luca, Giulia and Chiara, in standard Italian, on Chatterbox
  Multilingual. An Italian aligner times the words of every Italian line for SRT, VTT and
  `words.json`. With German, Spanish or French installed, the Italian voices download in seconds.
- **Read the Italian way.** Numbers (*ventuno*, *ventitré*, *duemila*), the decimal comma, dates
  (*1° maggio*), times (*14:30* or *14.30*), money with the sign before or after the amount
  (*€ 5*, *5 €*), ordinals (*1°*, *1ª*), Roman numerals read as ordinals (*Vittorio Emanuele II*,
  *XIX secolo*) and abbreviations such as *Sig.*, *Dott.ssa* and *ecc.* are read out in Italian.
  A speech closed by a second dash (*— Occhiacci di legno, perchè mi guardate? —*) stays one line.
- **Machine listening for Italian.** Turn it on for an Italian project, or press **Check now**,
  as for German, Spanish and French. Older spellings (*perchè*, *jeri*) and words that differ only
  by an accent or a silent *h*, such as *e* and *è* or *a* and *ha*, are not marked as wrong.

## 1.5.0 (2026-11-08)

French.

- **French voices** (Studio): Camille, Juliette, Louis and Hugo, in standard France French, on
  Chatterbox Multilingual. A French aligner times the words of every French line for SRT, VTT
  and `words.json`. With German or Spanish installed, the French voices download in seconds.
- **Read the French way.** Numbers (*soixante-dix*, *quatre-vingts*), the decimal comma, dates,
  times (*14 h 30*), money with the sign after the amount (*5 €*), ordinals (*1er*, *2e*),
  Roman numerals in names and centuries (*Louis XIV*, *XIXe siècle*) and abbreviations such as
  *M.*, *Mme* and *n°* are read out in French. Guillemets with France's spaces inside them
  (*« Va voir »*) open and close a sentence as quotes should.
- **Machine listening for French.** Turn it on for a French project, or press **Check now**, as
  for German and Spanish. French words that sound alike but are spelled apart, such as *et* and
  *est* or *chanté* and *chanter*, are not marked as wrong.

## 1.4.1 (2026-11-07)

Clearer first words in German and Spanish.

- **The first word of a line is no longer rushed or lost.** The German and Spanish voices
  sometimes swallowed a line's opening word: a quick "Es" in "Es war einmal", or a lone "Y" that
  went missing. Over six test stories, lost first words dropped from 48 to 10. Lines voiced
  in 1.4.0 are voiced again the next time you export them.

## 1.4.0 (2026-11-07)

Spanish.

- **Spanish voices** (Studio): Lucía, Sofía, Mateo and Diego, in neutral Latin American Spanish,
  on Chatterbox Multilingual. A Spanish aligner times the words of every Spanish line for SRT,
  VTT and `words.json`.
- **Stories as printed in 1918.** Old spelling in Quiroga's *Cuentos de la selva*, such as *fué*,
  *dió* and *vió*, is read as today's Spanish, and the captions keep the text as written.
  Numbers, dates, money (pesos, dólares, euros), times and abbreviations such as *Sr.* and
  *EE. UU.* are read out in Spanish. `¿` and `¡` open a sentence, never end one.
- **Machine listening for Spanish.** Turn it on for a Spanish project, or press **Check now**, as
  for German. In a project that mixes English and Spanish lines, each line is heard in its own
  language.
- **German and Spanish share one model.** The Chatterbox Multilingual model (2.7 GB) is now its
  own download, and each language's voices are a small one beside it. With German installed,
  the Spanish voices download in seconds. An existing German install is kept as it is, with no
  new download.

## 1.3.0 (2026-10-25)

German, and a second pair of ears.

- **German voices** (Studio): Greta, Lotte, Jonas and Friedrich, on Chatterbox Multilingual.
  The words of every German line are timed by a German aligner, for SRT, VTT and `words.json`.
- **Fairy tales as printed in 1857.** Old spelling such as *daß*, *Thür* and *seyn* is read as
  today's German, while the captions keep the text as written. Numbers, dates and
  abbreviations are read out in German.
- **Machine listening** (Studio, German for now). Turn it on for a project, or press
  **Check now**:
  - a speech recogniser and the aligner listen to each voiced line;
  - a line gets a **Listen:** chip when both heard a word differently, and **Maybe:** when one
    did. The chip shows what each one heard;
  - a filter shows only the lines to listen to.

  It is advice for you, made for anyone narrating a language they don't speak: it never
  re-voices a line on its own. Also in the CLI (`plainvoice verify`, `synth --verify`) and for
  agents (MCP `verify_project`).
- **No stray sound at the end of a line.** Chatterbox voices sometimes ended a line with a short,
  quiet blip after a moment of silence. It is now cut, in English and German.
- **Speed is for Kokoro voices.** The CLI help, the MCP schema and the plugin skill now say that
  Chatterbox and VieNeu voices speak at 1.0 only. Any other speed is refused, as before.
- **A PlainTake narration keeps a re-voiced take.** A line of a PlainTake steps project that you
  re-voiced at another seed or voice (`plainvoice revoice`) keeps it when PlainTake voices the
  steps again, instead of going back to the take it replaced.

## 1.2.0 (2026-10-23)

- **Any voice on any line.** A line can take any installed voice, of any language or model, so one
  project holds a whole dialogue (US, UK and Vietnamese voices together) and plays back in one
  Play all. Exports mix models at different sample rates.

## 1.1.1 (2026-10-23)

- **Voices** has a **Model** filter (Kokoro, Chatterbox, VieNeu), offering only the models the
  chosen language has. The default voice, then the featured ones, now always lead each group, so
  the "Featured first" checkbox is gone and the filters sit on one line.

## 1.1.0 (2026-10-22)

The app is easier to use by hand.

- **The Editor edits the script.** Rename the project and its chapters in place, add, move and
  delete chapters, and add, edit and delete lines. Edits are saved without voicing; one
  **Voice N lines** button voices every new or changed line in a single job.
- **A project toolbar** in the Editor: the project's voice and speed, the exports (each shown in
  Finder), **Play all**, which plays the whole project chapter by chapter and stops mid-way, and
  Move to Trash.
- **Every play button** shows a play icon, and a stop icon with Stop while it plays.
- **Projects** can be renamed, shown in Finder and moved to the Trash, which also clears their
  jobs from the Queue. A project with a running job points you to the Queue first.
- **Confirmations** before anything that cannot be undone: deleting a project, chapter, voiced
  line, model, voice or licence, and cancelling a job. Dialogs close on Escape and start on
  Cancel.
- **Queue** names each job by its project, links to it, and clears finished jobs.
- **Settings** shows the running version under Updates.
- The Editor opens from Projects and no longer has its own sidebar entry. Buttons, fields and
  menus share one flat style.

## 1.0.0 (2026-10-21)

The first release. macOS 14 or later, Apple silicon.

- **The app**, a window over the PlainVoice engine: Projects, Editor, Queue, Voices, Models,
  Pronunciations and Settings.
- **Voices.** Kokoro, 28 English voices (US and UK), free. VieNeu, 23 Vietnamese voices from the
  North, Centre and South, with English words mixed in, free. Chatterbox Turbo, 8 English voices
  with 19 expression tags such as `[laugh]` and `[whispering]`, in Studio.
- **Long jobs** in the background that resume after a quit, a crash or sleep. TXT, Markdown and
  EPUB import, chapters, and a queue shared by every client.
- **Exports:** WAV (48 kHz mono 16-bit), FLAC, M4A, M4B with chapters, SRT, VTT and
  `words.json`. Every audio export carries an AI-generated speech marker in its metadata.
- **Word timing on every line**: native for Kokoro, aligned for VieNeu and Chatterbox.
- **A quality check** that flags skipped or invented words and re-rolls the line.
- **Script markup:** `[word](respelling)`, `[word](/phonemes/)` (Kokoro), `[pause]` and
  `[pause:600ms]`, plus project and global pronunciation dictionaries.
- **Agents:** nine MCP tools (`plainvoice mcp`), their CLI twins, and a Claude Code plugin in
  this repository's marketplace. Agents write only inside the workspace and the folders you
  allow.
- **Studio:** Chatterbox voices and voice cloning with consent (VieNeu and Chatterbox). It is
  included with a PlainTake licence and activated once, in Settings or with
  `plainvoice licence activate`.
- **Check for updates**, by hand, in Settings or with `plainvoice check-updates`. PlainVoice never
  checks on its own.
- The app is ad-hoc signed and not notarised in this release. See the install guide for the
  first open.
