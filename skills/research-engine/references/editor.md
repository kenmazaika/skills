# 06.03 · Editorial gate

**Runs inside the Stage B session as a separate spawned context** (after `research.md` is persisted).
**Job:** protect your attention — decide whether this research earns a place in his Orbit feed.
Not to justify work already done.

## Allowed inputs (this context is allowed to be personalised)

- The research record: `questions/<id>/research.md`
- The neutral brief: `questions/<id>/brief.md`
- Discovery metadata: `questions/<id>/discovery.md`
- `02 - AREAS/02.08 - intent-map/Intent Map.md` (fresh read)
- `02 - AREAS/02.09 - work-map/INDEX.md` (+ a record only if needed)
- Prior dispatches: `orbit dispatch list --json` (last ~40)

## Score 1–5 on each, with a one-line written justification per score

| Criterion | Weight | 5 means | 1 means |
|---|---|---|---|
| Strategic relevance | 25% | Bears on a named goal or a live strategic uncertainty | Only tangentially interesting |
| Novelty | 20% | A distinction, dataset, or mechanism you almost certainly does not have | Generic best practice / obvious |
| Practical or intellectual value | 20% | Could change a decision, build, or mental model | Nice to know, changes nothing |
| Evidence quality | 20% | Credible primary sources; claims supported; limits honest | Thin, secondary-only, or overreach |
| Return on attention | 15% | Glad to spend several minutes; worth another item in the feed | Would skim and forget |

`weighted = 0.25·rel + 0.20·nov + 0.20·val + 0.20·ev + 0.15·att`, expressed as a percentage of 5 × weight sum.

## Threshold

Publish only if **all** hold:

- weighted ≥ **80%**
- every criterion ≥ 3
- evidence ≥ 4
- not substantially duplicative of a recent dispatch or research record

An interesting-but-inconclusive report may pass **only** if the uncertainty itself is strategically valuable
and the report says so plainly. Never inflate a score to maintain publishing frequency. **A rejection is a
successful outcome.**

## Write the decision

`questions/<id>/editorial.md`:

```markdown
# Editorial decision — <title>

| Criterion | Score | Justification |
|---|---|---|
| Strategic relevance | n/5 | … |
| Novelty | n/5 | … |
| Practical or intellectual value | n/5 | … |
| Evidence quality | n/5 | … |
| Return on attention | n/5 | … |
| **Weighted** | **nn%** | |

**Decision:** PUBLISH | REJECT
**Category:** Strategy | Systems | Growth
**Duplicate of:** <slug or none>
**Reason:** <one or two sentences>
```

## If REJECT

```bash
bin/research-engine reject --id <id> --reason "<short>" \
  --editorial-file "questions/<id>/editorial.md" --score <weighted-percent>
```

The research stays in the vault, quiet. No notification. No task. No card.

## If PUBLISH — write the Dispatch

Write `questions/<id>/article.md`. It should read like research journalism written for one smart reader:

- A specific, compelling title.
- An opening that makes the stakes clear in two or three sentences.
- **The answer or central finding early** — do not make the reader wait.
- The supporting research explained accessibly, with the interesting evidence and the counterpoints.
- What it implies for your projects or strategic thinking (concretely, not "consider exploring").
- Honest limitations and what remains unknown.
- Links to the original sources.

Avoid: generic AI intros, heading soup, fragmented bullet lists, repetitive conclusions, mechanical
references to the intent map, forced action items, rubric scores, process commentary, speculation presented
as fact. As long as the substance warrants; no padding.

Then:

```bash
adapters/orbit/publish.sh --slug "<kebab-slug>" --title "<title>" \
  --description "<one sentence>" --category "<Strategy|Systems|Growth>" \
  --file "questions/<id>/article.md"

bin/research-engine publish --id <id> --slug "<slug>" --dispatch-id "<id from publish output>" \
  --title "<title>" --score <weighted-percent>
```

If `orbit-publish.sh` succeeds but the local `publish` call fails, run
`bin/research-engine reconcile --id <id>` — it reads the dispatch back from Orbit and closes the gap. Never
publish the same slug twice (`--idempotency-key dispatch:<slug>` makes it a no-op anyway).

## Category guide

- **Strategy** — audience, positioning, offer, allocation, market.
- **Systems** — agent architecture, tooling, harness design, operations.
- **Growth** — distribution, SEO, audience building, content mechanics.
