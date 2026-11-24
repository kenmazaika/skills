#!/usr/bin/env bash
# dupe --slug <slug> → exit 0 if the slug already exists at the destination, 1 otherwise.
set -euo pipefail
: "${ORBIT_BASE_URL:?set ORBIT_BASE_URL}"
cmd="${1:-}"; shift || true
case "$cmd" in
  dupe)
    slug=""; while [ $# -gt 0 ]; do case "$1" in --slug) slug="$2"; shift 2;; *) shift;; esac; done
    orbit dispatch list --json | grep -q "\"$slug\"" && exit 0 || exit 1;;
  *) echo "usage: state.sh dupe --slug SLUG" >&2; exit 2;;
esac
