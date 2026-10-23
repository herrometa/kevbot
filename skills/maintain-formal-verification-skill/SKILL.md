---
name: maintain-formal-verification-skill
description: >
  Re-sync a repo's formal-* checks with code that moved since their
  last confirmation: read those commits, update the model from the
  code, rerun, and classify each failure as drift or bug. Use for
  /maintain-formal-verification-skill, "does the model still match",
  or after merges into covered code that never reran the check.
disable-model-invocation: true
argument-hint: formal skill to audit
---

# Maintain a formal verification skill

A model that has fallen behind the code can stay green while
describing functions that are gone. That green result reads like a
proof, so it is the case to fear. This skill handles changes that
bypassed the project skill: merges, edits by agents that never loaded
it, and slow drift over many commits.

Location and the generated-skill contract live in the discovered
**create-formal-verification-skill** skill. Do not restate them.

## Outcome per check

- **in sync.** Nothing since the last sync alters what the check
  models, and it passes.
- **updated.** The model now matches the new code, and it passes.
- **bug.** The model matches current code and the code violates the
  property. That is a code finding, not drift.
- **blocked.** It could not be re-synced or could not run. Give the
  concrete reason.

One check may end both updated and bug.

## Scope

Touch only verification files: models, harnesses, properties, and the
project skill. Product code only on the user's request. Never relax a
property or model to turn a failure green.

## Pass

1. **Find the checks.** Look for `formal-*` skills, then any project
   skill that drives a model checker, prover, or verifier against
   named code. Per check, note the property, covered code, bounds,
   command, and sync commit. No sync commit recorded: take the last
   commit touching the model files, and say so.
   Nothing found: stop and point at
   `/create-formal-verification-skill`.
2. **Run as-is.** Record the result before editing. Green here only
   says the old model still holds. Do not classify a red result yet.
3. **Read every covered change.** Diff covered files from the sync
   commit to `HEAD` and read the messages. Follow renames, splits,
   and moves. Search for new code that writes the guarded state.
   Classify each change:
   - **No effect.** Judged against the model, not the commit
     message.
   - **Shape changed.** An atomic step split, a branch added, a check
     moved, a new route to the guarded state, a widened value range.
     The model must change.
   - **Promise changed on purpose.** The change itself says so (doc
     comment, tests, changelog, message). The property changes, citing
     that evidence.
   - **Promise maybe broken.** The code moved with no such evidence.
     A later failure is a bug candidate.
4. **Update from the code.** Write the model edit from the code
   before rerunning, not from what turns it green. Keep atomic steps
   atomic. Edit a property only for an intended promise change, and
   record old wording, new wording, and evidence. Keep bounds unless
   the change invalidates them; report any reduction.
5. **Rerun and judge.**
   - **Green.** Sabotage the new code in the way the property is
     meant to catch and confirm the check goes red. Undo the
     sabotage.
   - **Red.** Walk the counterexample through real code one step at
     a time. A step the code cannot take means the model is wrong;
     fix it and say what was wrong. If every step is reachable, it is
     a bug: name the introducing commit, the steps in the code's
     words, and the harm. A cheap repro against real code is report
     evidence, not a product commit.
6. **Update the skill.** Coverage, commands, bounds, assumptions,
   and the sync commit, set to the commit you verified against. A
   blocked check keeps its old sync commit. Then walk the skill once
   as the next agent would.

**Reply:** per check, the outcome and the commits read; each model
edit and why (shape change, or intended promise change plus
evidence); the rerun plus the sabotage that proved it can still fail;
each bug as steps, harm, and introducing commit; remaining coverage
gaps. Separate drift from bugs explicitly. If a check was green
before the update and red after, say the earlier green came from a
stale model. Verification edits go in their own commit, apart from
any product fix, and only if the user asked for commits.
