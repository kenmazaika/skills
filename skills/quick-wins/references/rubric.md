# Quick Wins — selection rubric

Score each dimension 1–5. Weighted total is normalised to 100. Two floors decide the outcome before the
total matters.

| Dimension | Weight | 1 | 3 | 5 |
|---|---|---|---|---|
| Strategic alignment | 20% | unrelated to any live goal | supports a goal indirectly | directly advances a named goal from the Intent Map |
| Potential impact | 25% | cosmetic | measurable but modest | changes an outcome the human cares about |
| Human attention (inverted) | 20% | needs hours of human work | needs a decision plus a small task | needs one approval or one short answer |
| Agent autonomy | 15% | agent can only advise | agent does most, human verifies | agent investigates, builds, tests, verifies end to end |
| Confidence | 10% | speculation | plausible, some evidence | verified against the live system |
| Feasibility | 5% | needs capabilities that do not exist | doable with effort | doable with what exists today |
| Risk | 5% | irreversible, external, or costly | reversible with care | reversible, internal, no commitments |
| Timeliness | 5% | no reason for now | mildly time-sensitive | decays if not done this week |

## Floors (hard)

- **Impact ≥ 4** — below this it is busywork, however cheap.
- **Human attention ≤ 2** — 3 or worse means the human is doing the work.
- **Confidence ≥ 3** — unverified opportunities must be investigated further, not recommended.
- **Risk must be acceptable** — no irreversible or external action bundled into a "quick win".

## Weighted formula

`score = Σ(dimension_score / 5 × weight) × 100`

Recommend only at **≥ 80** with all floors met.

## Anti-patterns (auto-reject)

- Generic advice ("improve SEO", "post more consistently").
- Anything requiring the human to research, draft, or coordinate before the agent can start.
- Cosmetic-only changes with no outcome attached.
- A recommendation the agent could have executed itself.
- Building new infrastructure when an existing system already does it.
- The same proposal as last week without new evidence.
