#!/usr/bin/env bash
# Publish by writing the note to a directory. No platform required.
# Usage: publish.sh --slug SLUG --file PATH [--out DIR]
set -euo pipefail
slug="" file="" out="${FILE_OUT:-$HOME/notes}"
while [ $# -gt 0 ]; do
  case "$1" in
    --slug) slug="$2"; shift 2;;
    --file) file="$2"; shift 2;;
    --out) out="$2"; shift 2;;
    *) shift;;
  esac
done
[ -n "$file" ] || { echo "usage: publish.sh --slug S --file P" >&2; exit 2; }
mkdir -p "$out"
dest="$out/${slug:-$(basename "$file" .md)}.md"
cp "$file" "$dest"
echo "PUBLISHED: $dest"
