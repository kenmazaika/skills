#!/usr/bin/env bash
# Fails when a skill file contains a host path, a person, a product name, or a secret.
set -euo pipefail
cd "$(dirname "$0")/.."
PATTERNS='/home/[a-z]+|kenmazaika|notesfromtheloop|Buttondown|lumenthreadlabs|ws_ken|sk-[A-Za-z0-9]{20,}|Bearer [A-Za-z0-9._-]{20,}'
hits=$(grep -rInE "$PATTERNS" --include='*.md' --include='*.yaml' --include='*.sh' --include='research-engine' skills docs adapters 2>/dev/null || true)
if [ -n "$hits" ]; then
  echo "DENYLIST FAIL — personal or secret content found:"
  echo "$hits"
  exit 1
fi
echo "denylist OK"
