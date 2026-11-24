# Orbit adapter

Orbit is the default destination. It stores each note as an object with a slug, a revision history, and
a published state, and it can be read back to verify a write.

## Setup

```bash
export ORBIT_BASE_URL="https://orbit.example.com"
export ORBIT_TOKEN="…"          # or: orbit config set baseUrl/token via the CLI
```

The adapter shells out to the `orbit` CLI (`orbit dispatch publish`, `orbit dispatch show`,
`orbit dispatch list`). Install it separately; these skills do not vendor it.

## Files

- `publish.sh` — publish a markdown file, then verify by read-back. Exits non-zero on a mismatch.
- `state.sh` — `dupe --slug <slug>`: checks the destination before writing.
- `context.sh` — optional activity snapshot for Stage 1.

## Without Orbit

Set `publish.adapter: file` in the skill config. `adapters/file/publish.sh` writes the markdown to a
directory and the loop otherwise behaves identically. Nothing in `skills/**` depends on Orbit.
