# Agents

AI agents drive PlainVoice through MCP (`plainvoice mcp`, a stdio server) or the `plainvoice`
command. Both talk to the same engine as the app, so a job an agent starts shows up live in the
app's Queue, and you can fix one of its lines in the Editor.

Outputs are always file paths, never audio bytes. Agents may write only inside your workspace and
the folders you allow (see [Allowed folders](#allowed-folders)).

## Set it up

### From the app

**Settings → Agent setup** shows the setup for Claude Code and Codex, with the full path to the
`plainvoice` command inside the app, and a **Copy** button for each:

- Claude Code, run in a terminal:

  ```sh
  claude mcp add plainvoice -- /Applications/PlainVoice.app/Contents/MacOS/plainvoice mcp
  ```

- Codex, add to `~/.codex/config.toml`:

  ```toml
  [mcp_servers.plainvoice]
  command = "/Applications/PlainVoice.app/Contents/MacOS/plainvoice"
  args = ["mcp"]
  ```

Restart the agent, and it lists the nine PlainVoice tools below.

### The Claude Code plugin

The plugin adds the same MCP server plus a skill that teaches Claude the loop: lint, synthesize,
follow the job, fix flagged lines, use `words.json`. It runs `plainvoice mcp`, so first put
`plainvoice` on your `PATH` ([Install](install.md#the-command-line)). Then, in Claude Code:

```
/plugin marketplace add plainvoice/plainvoice
/plugin install plainvoice
```

Use either the plugin or the `claude mcp add` line, not both. To give Codex or another agent
the same instructions, paste the plugin's [skill](../plugin/skills/plainvoice/SKILL.md) into your
`AGENTS.md`.

## The MCP tools

| Tool | What it does | Returns |
|---|---|---|
| `list_voices({language?, engine?})` | lists the voices | id, language, sex, region, style, sample path, installed |
| `list_models()` | lists the model packs | size, licence, installed, tier |
| `install_model({id})` | downloads and installs a pack (the only tool that uses the network) | `{jobId}` |
| `lint_script({text, language})` | checks a script | issues: numbers, acronyms, unknown words, over-long lines, bad or ignored markup |
| `synthesize({text \| file, voice, language?, speed?, out?, formats?, chapters?})` | voices text or a TXT, Markdown or EPUB file | `{jobId, projectPath}` |
| `get_job({jobId, waitSeconds?})` | the job's state; waits up to 50 s | state, progress, time left, outputs (paths, durations), flagged and failed lines |
| `revoice_line({projectPath, lineId, text?, voice?, seed?})` | voices one line again and re-exports | `{jobId}` |
| `set_pronunciation({word, say, language, scope, projectPath?})` | stores a pronunciation, `scope` `"project"` or `"global"` | the stored entry |
| `cancel_job({jobId})` | cancels a job | its final state |

`get_job` lists every line whose quality check still failed after its re-rolls, so an agent can
fix exactly those lines with `revoice_line`.

## The command line

Every tool has a CLI twin, and a few commands are CLI-only. `plainvoice <command> --help` gives
the options.

| Command | What it does |
|---|---|
| `plainvoice voices` | list the voices (`list_voices`) |
| `plainvoice models` | list the model packs (`list_models`) |
| `plainvoice install <id>` | install a pack, with progress (`install_model`) |
| `plainvoice lint <file>` | check a script; exits 1 on an error (`lint_script`) |
| `plainvoice synth --voice <v> --text …\|--file …` | voice text or a file (`synthesize`) |
| `plainvoice job <id> [--wait]` | show or follow a job; `--resume` resumes one (`get_job`) |
| `plainvoice revoice <project> <lineId>` | voice one line again (`revoice_line`) |
| `plainvoice say <word> <respelling>` | set a pronunciation; `--list`, `--remove` (`set_pronunciation`) |
| `plainvoice cancel <id>` | cancel a job (`cancel_job`) |
| `plainvoice roots [add\|remove <dir>]` | list, add or remove the folders agents may write to |
| `plainvoice voice clone <clip.wav> --name … --sex … --lang … --consent` | clone a voice (Studio) |
| `plainvoice voice delete <voice>` | delete a cloned voice |
| `plainvoice licence [activate\|remove]` | show, activate or remove the Studio licence |
| `plainvoice check-updates` | ask the release channel whether a newer version exists |
| `plainvoice version` | print the version |
| `plainvoice mcp` | serve the MCP tools on stdin and stdout |

Add `--json` to `voices`, `models`, `lint`, `job` and `revoice` for machine-readable output, and
`--detach` to `synth` to print `{jobId, projectPath}` and return at once.

## Allowed folders

Agents may write only inside the workspace (`~/Documents/PlainVoice` unless you changed it) and
the folders you allow, in **Settings → Folders agents may write to** or with
`plainvoice roots add <dir>`. A write anywhere else is refused with the error `path.not_allowed`;
the agent should ask you to allow the folder, not try another path.

## Recipes

- **PlainTake:** `synthesize` with `steps` (a JSON array of `{stepId, text}`),
  `layout: "plaintake"` and `out` writes one clip and one word-timing file per step, where
  PlainTake reads them. A re-run voices only the steps whose text changed.
- **Remotion and other video tools:** voice into your project's `public/` folder with
  `--formats wav,words`, then place captions from `words.json`. Every `startMs` and `endMs` is
  milliseconds from the start of the WAV.
