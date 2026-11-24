---
name: personal-strategist
description: Daily strategic loop over your own project context. Reads a charter (goals, intent map, work map), generates candidate opportunities, ranks them with a hard rubric, researches the winner, and publishes at most one note a day — or nothing.
version: 0.1.0
license: MIT
tags: [strategy, agents, loops, orbit]
---

# Personal Strategist

A daily loop that turns your own context into **one** decision-grade question. It is not a content
generator and not a task manager: its job is to find the highest-leverage thing you are *not* doing,
prove it with evidence from your own systems, and say what you would actually do.

Most runs publish nothing. That is the design, not a failure.

## The five stages

| Stage | What happens | Output |
|---|---|---|
| 1 · Understand | Read the charter, then the intent map, then the work-map index. Open only the 2–4 records that matter. Take an activity snapshot. | `runs/<date>/00-material.md`, `00-snapshot.md` |
| 2 · Generate | Five candidates from the eligible modes, each with the question, why now, and what evidence would settle it. | `01-candidates.md` |
| 3 · Rank | Score every candidate against `references/rubric.md`. Keep the best, or stop. | `02-question.md` or `04-skip.md` |
| 4 · Research | Check that the mechanism does not already exist; gather the receipts. | `03-research.md` |
| 5 · Publish or skip | One note (300–500 words) through the publish adapter, or a recorded skip with a reason. | `05-decision.md` |

## Modes

Three lenses, one pipeline (`references/modes.md`):

- **Growth** — reach more of the right readers with what already exists.
- **Systems** — remove a class of recurring failure.
- **Challenger** — is the current work the right work at all?

Eligibility is a schedule; it is not an obligation. Generate across every eligible mode and rank
together — do not rotate for variety.

## The gate

`references/rubric.md` — five dimensions, 1–5 each. Publish only at **≥20/25**, with **no dimension
below 3** and **grounding ≥4**. Novelty ≥3. A duplicate of a published note is not a candidate
(`references/dedupe.md`).

If nothing clears the gate, write `04-skip.md` with the reason and stop. Zero notes is a successful run.

## The note

```
## What I noticed
## What I found
## Why it matters
## Evidence
## What I'd do
```

300–500 words. The evidence section carries paths, numbers, or links — never adjectives.

## Configuration

`config.example.yaml` holds the only things that should differ between deployments: charter paths,
cadence, volume caps, destinations, and the announce channel. If you find yourself editing a rubric to
fit your situation, you are probably editing the wrong file.

## Run batons

Every run writes files and hands off to a fresh process with no shared context. The next process reads
the *file*, not the reasoning that produced it — which is what lets Stage 3 critique Stage 2 honestly.

## Publishing

`publish.adapter: file` writes the note to a directory and stops. `publish.adapter: orbit` also
publishes it as an object and verifies by read-back. `none` drafts only. See `adapters/orbit/README.md`.
