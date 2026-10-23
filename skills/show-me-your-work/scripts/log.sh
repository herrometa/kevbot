#!/usr/bin/env bash
# Append one decision-log row. Columns owned by ../SKILL.md.
set -euo pipefail

usage() {
  printf 'usage: log.sh <logfile> <phase> <decision> <why> <evidence> <result>\n' >&2
  exit 2
}

[[ $# -eq 6 ]] || usage

logfile="$1"
phase="$2"
decision="$3"
why="$4"
evidence="$5"
result="$6"

cell() {
  local s="$1"
  s="${s//$'\t'/ }"
  s="${s//$'\n'/ }"
  s="${s//$'\r'/ }"
  case "$s" in
    =* | +* | -* | @*) s="'${s}" ;;
  esac
  printf '%s' "$s"
}

header=$'ts\tphase\tdecision\twhy\tevidence\tresult'
ts="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

dir="$(dirname "$logfile")"
mkdir -p "$dir"

# Append, never truncate: if this test misfires on a network mount,
# the cost is a stray header line, not the rows.
if [[ ! -s "$logfile" ]]; then
  printf '%s\n' "$header" >>"$logfile"
elif ! IFS= read -r first <"$logfile" || [[ "$first" != "$header" ]]; then
  printf 'error: %s is not a show-me-your-work log\n' "$logfile" >&2
  exit 1
fi

printf '%s\t%s\t%s\t%s\t%s\t%s\n' \
  "$ts" \
  "$(cell "$phase")" \
  "$(cell "$decision")" \
  "$(cell "$why")" \
  "$(cell "$evidence")" \
  "$(cell "$result")" >>"$logfile"
