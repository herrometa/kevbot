# Feature map

The map is the repo's maintained list of user-facing features this
skill knows how to prove. Keep it under the skill:

```text
features/README.md      index
features/<feature>.md   one file per feature
```

Start with the top 3–5 you can name from routes, commands, menus, or
docs. Missing later is maintain's job. Invented features are not.

## Index (`features/README.md`)

```markdown
# Feature map

| Feature | File | Surface |
| --- | --- | --- |
| <name> | [<file>.md](<file>.md) | web / cli / api / ... |
```

Every sibling `*.md` except `README.md` has a row. Every row has a
file.

## Feature file

```markdown
# Feature: <name>

## What it is

<user-facing behavior in one short paragraph>

## How a user reaches it

<clicks, commands, URLs, from a cold start of the app>

## How the harness drives it

<exact selectors, argv, or HTTP from this repo's Drive section>

## Observable end state

<what you can see, read, or query that means it worked>

## Gotchas

<preconditions, auth, timing, "do not double-drive">
```

Write from the user's point of view. Cite repo paths for selectors
and commands. If a feature cannot be reached without auth or extra
state, say that in Gotchas. Do not pretend a public path exists.

If seed data lacks a precondition a journey needs, the journey fails
and the reason goes in Gotchas. Do not weaken the journey until it
passes.
