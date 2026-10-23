---
name: create-formal-verification-skill
description: >
  Write a repo-local formal-<area> skill that machine-checks one
  high-stakes promise tests rarely exercise, using the verifier that
  fits the question. Use for /create-formal-verification-skill, "can
  this race happen", "check this invariant for all inputs", or for
  locking, retry, state-machine, parser, or unsafe code.
disable-model-invocation: true
argument-hint: area or bug, if one is already suspected
---

# Create a formal verification skill

A test samples the cases its author imagined. A formal check
exhausts a declared space: all interleavings of a model, all inputs
below a size, or all inputs. Find the place in this repo where that
difference matters most, check one property there, and leave a
project skill that reruns the check on later changes. Apply
**encode-the-rule**: the skill is the encoding.

Report results so the user can act on them without reading the
verifier's language.

## 1. Pick the target

Read the code first. Ask the user only for facts the checkout cannot
show. A user-named area or bug is the starting point.

Look for a guarantee the code gives its callers, where a violation
hurts users and the violating case is hard for tests to hit. Choose
the most valuable such guarantee, not the most convenient.

## 2. Pick the tool

The question picks the tool. Ordering questions ("can these steps
interleave badly?") suit a model checker run on a compact model; use
TLA+ unless something else fits better. Per-input questions (memory
safety, overflow, a container's invariant) suit a verifier that reads
the real code. If no such verifier supports the language, say so and
fall back to property-based tests on the real code rather than a
hand-written model of it. A claim that must hold unboundedly, where
a bound proves too little, may need a proof assistant. Favor tools
the repo's developers can install. Explain the choice.

## 3. Build the check

Hold each of these:

- **Traceable.** Every model element maps to code a reviewer can
  open. Granularity matches: an atomic model step is atomic in the
  code. Use the repo's names.
- **Falsifiable.** Demonstrate each property catching a deliberately
  broken copy of the guarded code, such as a dropped check or swapped
  steps. A check never seen failing proves nothing.
- **Honest findings.** If current code violates the property, report
  the counterexample in terms of the code. Never relax the model or
  the property to get a pass. Leave product code alone unless asked.
- **Scoped.** List bounds, assumptions, and exclusions. A pass speaks
  for the modeled or bounded space only.
- **Readable.** One plain sentence for the property and one for the
  harm. Counterexamples as a short numbered trace in the code's
  vocabulary.
- **Cheap.** One command, a pinned verifier version, and a runtime
  short enough to use on every relevant change (**build-the-lever**).
- **Synced.** List the files and functions under each check, plus
  the commit where the model was last confirmed against them.

## 4. Write the project skill

Location: `<repo>/.agents/skills/formal-<area>/SKILL.md`, `name`
matching the directory. The `formal-` prefix keeps **prove** from
treating it as an app driver (those are `verify-*`). The frontmatter
description says what it checks and when to run it.

A cold agent reading only that skill must be able to:

- decide whether its change touches covered code (the coverage
  list),
- run the check (exact command),
- separate a real bug from a modeling mistake (replay the trace
  against the code),
- update the model for an intended change, and advance the sync
  commit only after confirming the model matches the new code.

Real commands, paths, and names only. No placeholders.

## 5. Run it once

Act as the next agent. Introduce a scratch edit to real code that
violates the property, then follow the generated skill. The check
must flag it. Revert the edit and confirm the check returns to its
earlier result: green, or red only on findings you will report. If
the break went unnoticed, repair the skill or the model, not the
scratch edit. An unexecuted skill is a draft.

## 6. Hand off

**Reply:** the property in plain words, the tool and why, the
bounds, the result, the command, and the gaps. Mention a second
target only when one is clearly close behind. Point at
`/maintain-formal-verification-skill` for upkeep after changes that
skipped the check. Commit only if asked.
