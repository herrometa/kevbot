---
name: sharpen
description: >
  Make a task deeper rather than larger, then return a rewritten
  prompt. Use for /sharpen or "make this ask better".
disable-model-invocation: true
argument-hint: the task or prompt to sharpen
---

# Sharpen

The user wants a deeper version of the task, not more of it. Do not
start the work.

Work out these four first, specific to this task:

1. What would an expert in this field do here that the prompt does
   not ask for?
2. What raw source would they start from, instead of the summary the
   user already has?
3. Which methods and tools would they use?
4. What outside check, not you and not the user, would show the
   result is right?

Then rewrite the prompt so it asks for exactly that. Leave the
user's own decisions open; do not decide them in the rewrite.

**Reply:** only the rewritten prompt, in a fenced block. The four
answers shape it; they are not the deliverable.
