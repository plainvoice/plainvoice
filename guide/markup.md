# Script markup

Write these markers straight into a script. They work in pasted text, TXT, Markdown and EPUB, and
from the app, the CLI and MCP alike. Captions, SRT, VTT and `words.json` never contain markup.

## Respelling

```
Say [Siobhan](shivawn) first.
```

Speaks "shivawn", while the captions and `words.json` keep "Siobhan". The bracketed part may be
several words. A respelling uses letters, spaces, apostrophes and hyphens only; anything else
after `](` is read as an ordinary Markdown link and reduced to its text, so Markdown scripts with
links still import.

## Phonemes (Kokoro voices)

```
[Kokoro](/kˈOkəɹO/) is the voice model.
```

Raw phonemes between slashes, in Kokoro's phoneme set. VieNeu and Chatterbox voices cannot speak
them, so lint reports `markup.unsupported` for those voices.

## Pauses

```
First point. [pause:600ms] Second point.
```

`[pause]` ends the line there. With a length from 50 to 5000 ms (`[pause:600ms]`), that much
silence comes before the next line. A bare `[pause]` adds no silence beyond the normal gap between
lines.

## Expression tags (Chatterbox voices, Studio)

```
Oh, that's hilarious! [chuckle] Um, anyway.
```

Chatterbox Turbo acts these 19 tags instead of reading them:

`[angry]` `[fear]` `[surprised]` `[whispering]` `[advertisement]` `[dramatic]` `[narration]`
`[crying]` `[happy]` `[sarcastic]` `[clear throat]` `[sigh]` `[shush]` `[cough]` `[groan]`
`[sniff]` `[gasp]` `[chuckle]` `[laugh]`

Case does not matter (`[Laugh]` works). A tag never shows in the captions or `words.json`. Any
other `[tag]`, and every tag in a Kokoro or VieNeu project, is removed, and lint warns
`markup.tag_ignored`.

## Which pronunciation wins

An inline marker beats the project dictionary, which beats the global dictionary. Within one line,
a respelling also applies to a later plain use of the same word; split the line if you don't want
that.

To fix a word everywhere, add it in **Pronunciations** in the app, with **Say it as…** on a word in
the Editor, or from the command line:

```sh
plainvoice say Siobhan shivawn                       # global
plainvoice say Siobhan shivawn --project <project>   # this project only
```

A dictionary change applies to lines voiced from then on. Lines that contain the word are voiced
again the next time you synthesize the project.

## Mistakes

A malformed marker fails lint and synthesis with `markup.invalid`, giving the line, the column
and the marker. Run `plainvoice lint <file>` (or let the app's New dialog check the text) before a
long job.
