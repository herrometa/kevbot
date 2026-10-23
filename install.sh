#!/usr/bin/env bash
# Link kevbot skills and agents into Claude Code's user directories.
# Does not edit settings.json, AGENTS.md, or CLAUDE.md.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
CLAUDE_SKILLS="$CLAUDE_HOME/skills"
CLAUDE_AGENTS="$CLAUDE_HOME/agents"

mkdir -p "$CLAUDE_SKILLS" "$CLAUDE_AGENTS"

link_dir() {
  local src="$1"
  local dest="$2"
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    printf 'skipped %s (exists and is not a symlink)\n' "$dest" >&2
    return
  fi
  ln -sfn "$src" "$dest"
  printf 'linked %s -> %s\n' "$dest" "$src"
}

for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"
  link_dir "$d" "$CLAUDE_SKILLS/$name"
done

if [[ -d "$ROOT/agents" ]]; then
  for a in "$ROOT"/agents/*.md "$ROOT"/agents/claude/*.md; do
    [[ -e "$a" ]] || continue
    link_dir "$a" "$CLAUDE_AGENTS/$(basename "$a")"
  done
fi

printf '\nkevbot installed for this user.\n'
printf 'Claude: %s and %s\n' "$CLAUDE_SKILLS" "$CLAUDE_AGENTS"
printf 'Next: open a session and run /setup-kevbot\n'
