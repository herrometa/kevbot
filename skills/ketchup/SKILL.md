---
name: ketchup
description: >
  Bring the user current on this chat since they last wrote, plainly,
  then lay out each pending call of theirs with what they need to
  make it without clicking through. Use for /ketchup or "what did I
  miss here".
disable-model-invocation: true
---

# Ketchup

Assume the user knows everything up to what they last typed, and
nothing since. Tool results, notifications, and child reports are not
their messages. Bring them current, then hand them every call that is
theirs.

Voice is **bro**'s: plain words, short sentences, like a teammate at
the desk. Describe outcomes for them, not your process. Leave out
hashes, paths, commands, and counts unless they need one to act. Name
each PR, branch, or child the way the user would.

For a catch-up across sessions or days, use **recall** instead.

## Gather

Read-only turn. Do not edit, start jobs, or post anything.

- Your own work since that message, child reports, and anyone
  else's messages in this chat.
- The live state of every PR, CI run, and child this chat touched.
  Verify every figure you plan to show against where it came from.
  Say so when you correct one.
- Action items: calls only the user can make (a product choice, an
  approval, something irreversible, access you lack). Include ones
  raised earlier and still open. Work you can do yourself is not an
  action item. Do not invent one to fill the reply.

For each item: link, what it changes for users, the evidence for
your pick, the risk, and your pick. Write `unknown` for a missing
fact. Omit a link you do not have.

## Write

1. One sentence: what waits on the user, or that nothing does. If
   nothing happened and nothing waits, say that and stop.
2. What happened, pictures first, under about 100 words of text.
   Embed screenshots or recordings the work produced. Add a diagram
   only when a picture explains a change faster than words. Then one
   bullet per thing the user asked for: the outcome and whether it
   is done, running, failed, or unchecked. Each bullet must stay
   true read alone. Never call something done that still waits on
   the user. Name bugs found and fixed along the way. End with one
   line on work you can still do yourself.
3. Action items, about 30 words each. Never drop or merge items to
   save words; no count in place of a list, no link in place of an
   item.
   - One item, one call: a bullet with the call, your pick, user
     impact, evidence, and risk.
   - Many items, one call (merge these PRs): the call and pick once,
     then a bullet per item, riskiest first.
   - A choice between options: each option with what it gets and
     what it costs, which is the risk.
   Give risk even when low. Mention the cost of waiting only when it
   is more than delay.

## Visuals

A visual is a screenshot, a recording, a Mermaid diagram, or a
chart. A table is not a visual. Draw how something connects, a
dependency chain with each state, a before and after, or options
side by side. Do not draw status lists or unconnected boxes. At most
six boxes, eight words each, in plain labels. Never draw a screen you
did not capture or a number you do not have. If the harness cannot
render images, say "no screenshot" and describe what changed on
screen in one line.
