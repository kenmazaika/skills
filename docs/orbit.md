# Orbit (default adapter)

These skills assume a destination that can store a document, give it a stable slug, and read it back.
Orbit is that destination by default. It is not required.

## Setup

```bash
export ORBIT_BASE_URL="https://orbit.example.com"
export ORBIT_TOKEN="…"
```

The adapter calls the `orbit` CLI:

| Command | Used for |
|---|---|
| `orbit dispatch publish <file> --title … --slug …` | publish a note |
| `orbit dispatch show <slug> --json` | verify by read-back (never trust an unauthenticated 200) |
| `orbit dispatch list --json` | dedupe before publishing |

## Why read-back

A publish call that returns success is not proof the document exists. `publish.sh` re-reads the object and
fails the run if the slug or the published state does not match. `research-engine reconcile` repairs the
case where the write landed but the local acknowledgement did not.

## Turning it off

```yaml
publish:
  adapter: file      # writes markdown into a directory
  # adapter: none    # draft only
```

Nothing under `skills/**` imports Orbit or assumes its API shape. The adapter is the whole boundary.
