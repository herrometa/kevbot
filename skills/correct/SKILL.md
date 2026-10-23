---
name: correct
description: >
  Turn the mistakes agents repeat in this repo into ones they cannot
  make, preferring the strongest enforcement that fits. Use for
  /correct, "stop making this mistake", or after the user corrects
  the same thing twice.
disable-model-invocation: true
argument-hint: mistake or area, if one is already known
---

# Correct

The user keeps catching the same agent mistakes here. Change the repo
so the next agent cannot make them.

Assume the next contributor is an agent that read one file, copied
the nearest example, and took the shortest path that compiles. A
change that looks right from one file should be right for the repo.

## Steps

1. Collect evidence. Recent commits and reverts, review comments,
   agent instruction files, workaround comments, and this session's
   corrections. Group them into mistake classes. A class needs two
   occurrences.
2. For each class, pick the highest level that works
   (**encode-the-rule**):
   1. **Structure.** One owner per piece of state, one supported way
      per task. Make internals private so reaching for them breaks
      the build. Generate lists that people sync by hand. Delete old
      paths an agent would copy
      (**migrate-callers-then-delete-legacy-apis**).
   2. **Types.** Make the bad state unwritable
      (**type-system-discipline**). If wrong code still builds, add a
      lint or CI rule whose message tells the agent what to use. If
      the pattern is already widespread, fail only on new
      occurrences.
   3. **Tests.** Fix or delete tests that miss the behavior they
      claim to cover (**test-behavior**).
   4. **Docs or agent rules.** Last, for judgment calls only. Nothing
      fails when an agent skips them.
3. Land the most frequent classes now, one commit each if the user
   asked for commits. Show each new guard rejecting an actual
   historical instance (check out the old code, or replay the bad
   diff). Run the same command locally that CI runs.
4. Exceptions live on the offending line with a reason and an
   expiry. Granting one is the user's call.
5. Keep a rule table in the repo's agent instruction file: rule,
   and what enforces it. A rule that is already listed with nothing
   enforcing it is a repeat. Move it up a level in the same change.
   Retire a rule when its mistake is no longer possible.

**Reply:** per class, the occurrences that prove it, the level
chosen, why nothing stronger fit, and the command that shows the
check failing on the old mistake.
