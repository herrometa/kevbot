# kevbot

Engineering skills for Claude Code. Markdown procedures the agent
loads and follows; the capability contract in
[references/harness.md](skills/kevbot-mode/references/harness.md)
defines fallbacks when a tool is missing.

```text
/kevbot-mode <goal, and how you will know it is done>
```

`/kevbot-mode` picks a playbook, applies the principles that change a
decision, and keeps subagent fan-out in the parent. Why that shape:
[docs/why.md](docs/why.md).

## Install

```bash
./install.sh
```

Symlinks `skills/*` into `~/.claude/skills/`, and
`agents/kevbot-agent.md` plus the reviewers in `agents/claude/` into
`~/.claude/agents/`. Honors `CLAUDE_CONFIG_DIR`. Skips any destination
that exists and is not a symlink. Does not edit `settings.json`,
`AGENTS.md`, or `CLAUDE.md`. Re-run after new skills appear.

## Setup

```text
/setup-kevbot
```

Writes `~/.claude/kevbot-models.md` if you want per-role model
overrides. Offers a project `verify-*` skill when the current repo
has a runnable app and none exists. Optional always-on routing:

```text
Non-trivial engineering work (bug, feature, refactor, investigation):
read and follow the kevbot-mode skill before acting. Casual questions stay
ordinary chat. The user can opt out for a turn by saying so.
```

Put that in a user or project `CLAUDE.md`.

## Commands

| Command | When |
| --- | --- |
| `/kevbot-mode` | Non-trivial engineering work |
| `/help` | List kevbot skills |
| `/how` | Walk a subsystem, read-only |
| `/prove` | Exercise the real artifact |
| `/figure-it-out` | No narrower playbook fits |
| `/interrogate` | Adversarial review of a change |
| `/recall` | Catch up on recent work |
| `/teach` | Explain so a person understands |
| `/tdd` | Failing check before production code |
| `/bro` | Restate the last message plainly |
| `/unslop` | Cut AI tells from prose |
| `/no-comments` | Strip narrative comments |
| `/reflect` | Mine this session into skill edits |
| `/show-me-your-work` | Decision log for long runs |
| `/make-bot-ui` | Local page that wakes agent work |
| `/nudge` | Nudge every N minutes; Yes writes a team update |
| `/create-verification-skill` | Repo has an app and no `verify-*` yet |
| `/maintain-verification-skill` | That skill or its map drifted |
| `/setup-kevbot` | Install check and model sheet |
| `/ketchup` | Catch up on this chat; list your pending calls |
| `/in-your-own-words` | Play back the goal before work |
| `/sharpen` | Rewrite a prompt to ask for a deeper task |
| `/correct` | Make a repeated agent mistake impossible |
| `/benchmark-checklist` | Vet a measured speedup or regression |
| `/create-formal-verification-skill` | Model-check or prove one risky promise |
| `/maintain-formal-verification-skill` | That formal check drifted from the code |

Playbooks behind `/kevbot-mode`: `investigate`, `fix`, `build`,
`reshape`, `leave-running`.

`/prove` prefers `<repo>/.claude/skills/verify-<app>/`, then an
existing harness, then a one-off invocation. Create writes that
skill (launch, doctor, drive, evidence, feature map) and runs one
feature before handoff. Details: [docs/why.md](docs/why.md).

## Layout

```text
skills/kevbot-mode/                        dispatcher, playbooks, references
skills/principle-*/                        one rule each; slash-hidden
skills/how prove setup-kevbot help
skills/<name>/                             situational; /help lists them
skills/create-verification-skill/          owns verify-* contract
skills/maintain-verification-skill/
skills/create-formal-verification-skill/   owns formal-* contract
skills/maintain-formal-verification-skill/
agents/kevbot-agent.md                     child agent; no nested spawn
agents/claude/                             Claude-only reviewer agents
docs/why.md                                design argument
```

Harness tool names live only in `skills/kevbot-mode/references/`.

## Status

v0.2. No arena or Graphite autopilot. `/interrogate` runs the
`reviewers` list on this parent; an empty list means the parent
reviews. Competing designs: parent spawns isolated writers and
reads them.
