# Generated `verify-<slug>` skill

The file `<repo>/.claude/skills/verify-<slug>/SKILL.md` is for a cold
agent mid-task. No placeholders. Every command, port, selector, and
path must be one this repo actually uses.

## Frontmatter

```yaml
---
name: verify-<slug>
description: >
  Drive <app> (<surface>) the way a user does and capture proof.
  Use when proving a change to <app>, or when /prove needs this
  repo's harness.
---
```

`name` must match the directory.

## Required sections

### Launch

Exact command that starts the app for verification. How to know it is
ready (log line, prompt, a request that succeeds). Env vars, ports,
seed data, auth. Teardown of what this run started.

Launch reaches a usable state from an empty data directory,
including migrations and seed data. Ready means a user action would
work, not merely that a port is open. Databases often report healthy
before their init scripts finish.

A short-lived CLI has no server: launch means build or install once,
then each drive gets its own process.

### Doctor

One read-only check: is this instance worth driving? Process up, right
binary, port owned by this run, auth valid. Run doctor first whenever
anything looks off.

### Drive

How an agent operates the surface. Prefer an existing harness
(Playwright, expect, curl, a repo script). Only then a generic recipe
(browser for web/Electron, PTY for CLI/TUI, HTTP for a service).

Use stable handles from this repo: ARIA labels, `data-` attributes,
prompt strings, route paths, subcommands. Not coordinates or "hit Tab
six times".

### Evidence

What to capture and where it goes (directory named in the skill).
Proof standards:

- Exercise the real user path, not a test-only back door.
- Capture the action and the resulting state, not only the last
  screen.
- Check side effects (files, rows, messages) as well as what is
  visible.
- If the safe path is dry-run or test mode, observe what it actually
  skips (network, files, git refs). Do not trust the flag's name.

Evidence survives cleanup.

### Cleanup

Tear down instances and scratch this run created. Kill what you
started, not "whatever matches this process name". Do not delete
evidence.

### Helpers

Any script in the skill directory is executable. The skill body shows
the invocation. A helper the reader has to reverse-engineer is not a
helper.

### Feature map

Point at `features/README.md` in the same skill directory. A proof
that drives one convenient entry point is incomplete when the map
lists others that apply.

## Isolation

Say whether two instances can run side by side (ports, data dirs,
profiles). If they cannot, the skill must refuse to double-drive a
shared instance the user already has open.
