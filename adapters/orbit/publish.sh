#!/usr/bin/env bash
# Publish a markdown file to Orbit and verify the result by read-back.
# Usage: publish.sh --slug SLUG --title TITLE --file PATH [--summary TEXT] [--category TAG]
set -euo pipefail
: "${ORBIT_BASE_URL:?set ORBIT_BASE_URL}"
slug="" title="" file="" summary="" category=""
while [ $# -gt 0 ]; do
  case "$1" in
    --slug) slug="$2"; shift 2;;
    --title) title="$2"; shift 2;;
    --file) file="$2"; shift 2;;
    --summary) summary="$2"; shift 2;;
    --category) category="$2"; shift 2;;
    *) echo "unknown arg: $1" >&2; exit 2;;
  esac
done
[ -n "$slug" ] && [ -n "$file" ] || { echo "usage: publish.sh --slug S --title T --file P" >&2; exit 2; }
orbit dispatch publish "$file" --title "${title:-$slug}" --slug "$slug" \
  ${summary:+--summary "$summary"} ${category:+--tag "$category"} >/dev/null
got=$(orbit dispatch show "$slug" --json)
echo "$got" | grep -q "\"slug\": \"$slug\"" || { echo "verify failed: slug mismatch" >&2; exit 1; }
echo "$got" | grep -q '"status": "published"' || { echo "verify failed: not published" >&2; exit 1; }
echo "PUBLISHED: $slug"
