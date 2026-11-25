---
name: quick-wins
description: Opportunity discovery for delegation. Reads an Intent Map and a Work Map, investigates the live systems for evidence, and hands you at most one high-impact opportunity that needs one approval instead of your afternoon.
version: 0.1.0
license: MIT
tags: [opportunity, delegation, agents, loops, orbit]
---

# Quick Wins

The name is misleading. "Quick" does not mean small, and it does not mean fast for the agent. It means
**cheap in human attention**.

- An opportunity that costs the agent two hours and you one approval: excellent.
- An opportunity that costs the agent five minutes and you an afternoon: worthless.

This is not a task generator. It is an opportunity-discovery and delegation system. On many days the
correct output is **nothing**.

## What it needs

Two documents, referenced by configurable paths — never copied into this repo:

| Input | Answers |
|---|---|
| **Intent Map** | Where you are going: goals, priorities, beliefs, constraints, what counts as a valuable outcome. |
| **Work Map** | What you already have: projects, sites, repos, infrastructure, capabilities, channels, how to reach them. |

Read both fresh on every run. The opportunity lives at the intersection — a goal that an existing surface
could advance, with the agent doing the work.

## How a run goes

1. Read the Intent Map; name the 2–3 goals that are live right now.
2. Read the Work Map index; identify the surfaces that could advance them.
3. **Investigate beyond the maps.** Open the page, the repo, the job, the draft, the numbers. The maps are
   direction, not inventory.
4. Generate 3–7 candidates. Each one carries evidence you gathered *this run*: a URL, a file, a number, a
   quote from the live system.
5. Score with `references/rubric.md`. Hard floors: impact ≥4, human attention ≤2, confidence ≥3.
6. Recommend at most one, or write a no-recommendation record and stop.

## Selection criteria

| Dimension | Weight | What it means |
|---|---|---|
| Strategic alignment | 20% | directly advances a goal from the Intent Map |
| Potential impact | 25% | could change an outcome you care about |
| Human attention (inverted) | 20% | one approval or one short answer — not an afternoon |
| Agent autonomy | 15% | the agent can investigate, build, test and verify |
| Confidence | 10% | verified against the live system, not inferred |
| Feasibility | 5% | doable with capabilities that exist |
| Risk | 5% | reversible, internal, no commitments |
| Timeliness | 5% | decays if not done now |

**Impact floor first.** Never optimise attention so hard that the result is trivial. Cheap busywork is
still busywork. Target the shape: *agent does the work, human approves*.

Be honest about uncertainty: projected impact is not a guaranteed result, and the recommendation should
say what would have to be true for it to work.

## Delivery (default: Orbit)

`references/inbox-card.md` has the exact format. One card, readable on a phone in 20 seconds:

- **What** — the change, not the topic.
- **Why it matters** — the goal plus the evidence, one line each.
- **What the agent will do** — the actual work.
- **What you do** — one approval or one answer.

The card's `details` block is the Work handoff (`references/work-handoff.md`): goal, why, effort,
expected outcome, next steps, links. Moving the card to Work turns it into the execution brief. Marking it
read closes it **without** executing anything.

### Without Orbit

Set `delivery.adapter: report` — the opportunity is written to a markdown file (or printed) and nothing is
executed. Never silently substitute another channel, and never treat "shown" as "approved".

## Scheduling

Daily is a sensible default, at an hour that does not collide with the rest of your loop fleet. Any
scheduler works; the skill only needs a fresh process that reads the config and the two maps.

State lives next to the loop (`state/seen.json`): every proposal with its disposition. Before proposing,
check three things: the state file, the live inbox, and work already in progress. A repeat needs
materially new evidence.

## What must not qualify

- Generic advice ("improve SEO", "post more consistently").
- Anything requiring you to research, draft, or coordinate before the agent can start.
- Cosmetic changes with no outcome attached.
- Work the agent could have done itself.
- New infrastructure where an existing system already covers it.
- The same opportunity as last week, unchanged.

## Human involvement

Before asking, the agent must exhaust: existing context, direct inspection, independent research, and
reasonable reversible decisions. When it does ask, the request is a prepared artifact plus one action —
never "please go research this".

Approval to pursue a Quick Win is **not** authorization for external publishing, spending, destructive
changes, or contacting third parties. Those keep their own checkpoints.

## Files

- `references/rubric.md` — the scoring table, floors, and anti-patterns.
- `references/inbox-card.md` — the card format and rules.
- `references/work-handoff.md` — what makes a Work item actionable.
- `config.example.yaml` — every personal knob.
- `examples/end-to-end.md` — one run from maps to a delivered card.
