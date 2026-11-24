---
name: research-engine
description: Two-stage autonomous research loop. Stage A frames one question and writes a neutral brief; Stage B researches it in a fresh session with no access to the reasoning; a separate editorial gate publishes only what clears the bar.
version: 0.1.0
license: MIT
tags: [research, agents, loops, orbit]
---

# Research Engine

A recurring research loop that refuses to grade its own homework. It splits one job into three
processes that cannot see each other's reasoning:

1. **Stage A — question discovery.** Reads your charter (goals, intent map, work map) and recent
   history, generates ~5 candidate questions, scores them, and writes **one** question as a
   self-contained `brief.md`. It also writes `discovery.md` — why this question, what was rejected —
   which nobody downstream may read.
2. **Stage B — research.** A fresh process reads *only* the brief and the live web. No charter, no
   intent map, no discovery notes. It researches from primary sources, seeks contradictions, and
   persists `research.md` **before** any interpretation.
3. **Editorial gate.** A separate agent scores the research on five weighted criteria. Below the
   threshold, the result stays in the vault. Above it, a note is published.

That separation is the whole design. The moment Stage B can see why the question was chosen, it starts
writing the answer the author wanted.

## Quick start

```bash
git clone https://github.com/$GITHUB_USER/skills && cd skills/skills/research-engine
cp config.example.yaml ~/.config/research-engine/config.yaml   # edit paths
export RESEARCH_LOOP=~/.local/share/research-engine             # where state lives

scripts/research-engine status
scripts/research-engine create --question-file q.md --discovery-file d.md --title "…"
scripts/research-engine claim --wait 900 --json
scripts/research-engine complete --id <id> --research-file research.md
scripts/research-engine publish --id <id> --slug <slug> [--url <url>]
```

Schedule Stage A and Stage B as two jobs (e.g. 01:00 and 02:15). Stage B waits for Stage A's question
with a bounded `claim --wait`, so a slow Stage A does not lose the day.

## Lifecycle

`ready → researching → researched → published | rejected` (plus `failed` after N attempts).

- One question per day, enforced by `q-YYYYMMDD-<slug>` ids.
- `claim` takes a lease (default 6h) so two workers cannot research the same question.
- `reap` returns expired leases to `ready` and fails a question after `RESEARCH_MAX_ATTEMPTS`.
- `reconcile` re-reads the destination and repairs a publish that succeeded but never got acknowledged.

## The files

| File | Written by | Read by |
|---|---|---|
| `brief.md` | Stage A | Stage B, editor |
| `discovery.md` | Stage A | editor only |
| `research.md` | Stage B | editor |
| `editorial.md` | editor | you |
| `article.md` | editor (on publish) | publisher |

`references/stage-a.md`, `stage-b.md`, and `editor.md` are the full contracts, including the exact
templates and the scoring anchors. Read them before changing behaviour.

## The gate

Weighted score across strategic relevance (25%), novelty (20%), practical or intellectual value (20%),
evidence quality (20%), return on attention (15%). Publish at **≥80%**, with every criterion ≥3 and
evidence ≥4. **Never lower the threshold to make a run publish.** A rejection is a successful quiet run.

## Configuration

`config.example.yaml` documents every knob: charter paths, cadence, source minimums, thresholds, and
where output goes. Nothing in `skills/**` contains a host path, a person, or a product name — that is
enforced by CI.

## Orbit

Orbit is the default destination: it stores each note as an object with a stable slug, and the
`orbit` adapter publishes and verifies by read-back. If you do not use Orbit, set
`publish.adapter: file` — the adapter writes the note to a directory and the rest of the loop is
unchanged. See `docs/orbit.md`.
