---
title: "Run contract — Orbit Personal Strategist"
created: 2026-11-10
updated: 2026-11-10
type: schema
kind: fact
status: active
authority: upstream
tags: [orbit, contract, research]
---

# Run contract

Five stages. Each writes a baton. No stage may skip the one before it.

## Stage 1 — Understand

Run the snapshot builder, then read its output **before** thinking about topics:

```bash
$WORKSPACE/adapters/orbit/context.sh "$RUN"
```

**What it writes** — read `00-context.md` first, then `00-projects.md`:

- `$RUN/00-context.md` — five categories, source-cited: **Goals** (charter + registry), **Activity** (log,
  memory, commits, other loops), **Intent** (feedback ledger, dictations, sampled owner messages, **and your own
  words on Orbit artifacts**), **Pending** (Orbit inbox, agent actions, vault handoff/ticket unticked boxes,
  unresolved recommendations, **artifacts whose critique has not yet produced a revision**), **History**
  (Orbit dispatches, topic ledger, completed projects, **revision histories generated from feedback**). It opens
  with a **coverage table**.
- **Conversational feedback is the richest intent source.** `orbit.feedback` objects carry your actual words on
  a specific draft (e.g. "the last piece I want to do is make the transition at the end sell the course");
  `orbit.review` objects carry critic findings against a revision number; `orbit object revisions <artifact>`
  shows whether feedback produced a new draft. The snapshot reads all three (40 feedback · 11 reviews · 2
  artifacts at the time of writing) and links each feedback object to its artifact through the `targets`
  relation. Read these before proposing anything about an article he has already commented on.
- `$RUN/00-projects.md` — one card per active project: status, intended outcome / next action, last log
  mention, open inbox references, and **gap signals**. A gap signal is evidence (files moved but nothing was
  logged; no next action recorded), never a conclusion — verify in the files before claiming a mismatch.
- `$RUN/00-snapshot.md` — the legacy linear snapshot, kept for older batons. Not the primary read.
- `$RUN/00-snapshot.hash` — informational. Hashes the whole context, so it moves whenever any repo or any
  other loop moves. Never use it to suppress a run.
- `$RUN/00-material.md` + `$RUN/00-material.hash` — **the decision input.** your log entries, active-ball
  `next_action`s, published slugs, Orbit pending inbox/action ids, feedback records, and the newest blog
  posts. Unrelated commits and other loops' batons are deliberately excluded.

**Coverage rule.** The coverage table names every source and its status (`integrated`, `available but empty`,
`unavailable`). A missing source is a stated gap, never a silent assumption, and publication must never
depend on an unavailable one. ChatGPT, email and calendar are unavailable by design — do not reconstruct them.

**Ownership rule.** Orbit owns Orbit state (inbox, actions, dispatches, reviews); the filesystem owns vault
state (log, balls, handoffs). When they disagree, say which source you are reading and why.

### Map pass — after the activity snapshot

Read these before generating candidates:

1. **Intent Map** — `$VAULT/02 - AREAS/02.08 - intent-map/Intent Map.md`, in full. It is authoritative for why the work exists, what you
   values, and what he is trying to build. Do not copy it into the run batons or the cron prompt.
2. **Work Map entry point** — `$VAULT/02 - AREAS/02.09 - work-map/INDEX.md`, then `SYSTEM-OVERVIEW.md`, the latest entries in
   `CHANGELOG.md`, and `Operations/Current-State.md`.
3. **Select 2–4 relevant areas** from the intersection of intent and recent activity. Open only those Work
   Map records and their linked source evidence.

Use progressive disclosure. Do not read all Work Map documents, do not paste inventories into context, and do
not treat a synchronised change as an insight. A new commit, article, feature, or config change is a **signal**;
the candidate still needs a gap, contradiction, pattern, or overlooked connection that survives research.

If a Work Map record conflicts with live implementation, investigate the source and state the uncertainty. A
recent sync is not proof that every record is correct.

Then write `$RUN/00-understanding.md` — at most 12 lines:

- **Intent in play** — which Intent Map ambition/belief this period actually touched
- **Reality verified** — the 1–3 Work Map records/artifacts actually checked
- **Opportunity hypothesis** — what may be missing, contradictory, or overlooked
- **Recent work** — 3–6 concrete items with a date or a path
- **Decisions** — what changed direction
- **Open problems** — what is being fixed repeatedly, or is stuck
- **Assets** — existing work that could be reused (posts, receipts, code, research)

Noise filter: ignore routine syncs, generated artifacts, `Vault/09 - FLEETING` turn dumps, cron logs. A file
being recently modified is not evidence of importance. Evidence = your instruction, a decision, a repeated
failure, a shipped change, or a published post.

## Stage 2 — Generate candidates

Five **research questions**, not article topics. Each one carries:

```md
### C1 · <question>
- **Trigger** — the specific recent work (path / date / quote)
- **Intent** — which Intent Map ambition/belief this serves
- **Reality** — which Work Map record(s) and live evidence were checked
- **Opportunity** — the specific gap, contradiction, pattern, or overlooked connection
- **Goal** — which operating priority and which clause
- **Mode** — A / B / C
- **Answer would change** — the decision, experiment, or asset it affects
- **Evidence that would kill it** — what result means "not worth publishing"
```

A candidate with no trigger line is invalid — delete it. "Blog growth" is not a trigger; "the harness-inspect
post shipped 2026-11-10 and GA shows 0 key events" is.

A candidate that only summarizes the Work Map, restates the Intent Map, or recommends a capability already
documented as live is invalid — replace it, do not soften it.

## Stage 3 — Rank and select

Score every candidate with `RUBRIC.md` (five dimensions, 0–5). Write `$RUN/01-candidates.md` with the table,
then `$RUN/02-question.md` for the winner: why it beat the others, what evidence would change the answer, and
which prior note or rejected idea it is nearest to (and why it is not a duplicate).

Selection rules: ≥20/25 total, no dimension below 3, grounding ≥4. Before selecting, run the dedupe check:

```bash
adapters/orbit/state.sh dupe --slug <slug>   # exit 0 = known (prints DUP + status), 1 = new
```

It reads `seen-topics.md` **and** the live Orbit dispatch list, so a published slug cannot re-enter through a
malformed table row.

**Research questions are not decisions (2026-11-24).** An open `06.03 - research-engine` question is
background reading, not an unresolved human decision. It must not block this loop or be treated as a
duplicate. Only a **published** Dispatch or a `seen-topics.md` row counts as duplication. If a candidate
overlaps an open 06.03 question, keep it only when this loop's angle produces an actionable recommendation;
otherwise take the next candidate — never skip the day because 06.03 asked something related.

**Prior-advice gate.** Before selecting, read `state/outcomes.json` (synced from Orbit dispatch feedback) and
the generated lessons at the bottom of `feedback.md`:

- `acted_on` or `useful` on a similar note → the topic already landed; do not re-recommend unless the project
  situation materially changed.
- `already_knew` → do not re-explain something he already runs.
- `rejected` (Not relevant) → needs materially new evidence, never a rewording.
- no signal → unseen, **not** rejected. Low weight; never treated as positive.
- A prior rejection informs the next recommendation; it does not ban the topic.

If nothing clears the gate → `04-skip.md`, then record the skip (below), stop. That is a successful run.

**Map-aware auto-fails.** Reject a candidate whose main content is a Work Map inventory tour, a restatement of
your goals, generic best-practice advice, or a recommendation for something already implemented. The
candidate must add a new fact, pattern, contradiction, or connection, and it must cite the specific records or
artifacts that make it true.

## Stage 4 — Research

Independently investigate the selected question. Requirements:

- **Outside the vault.** At least one finding you could not reconstruct from his own material, with a URL.
- **Artifact evidence.** Cite at least one concrete artifact, Work Map record, code path, workflow, email/CTA
  configuration, experiment, or observed result. Name what was checked; do not rely on the map's summary alone.
- **Adversarial pass.** Search for the case *against* the hypothesis before writing. Record it in
  `$RUN/03-research.md` under **Counter-evidence**.
- **Concrete.** Named examples, numbers, dates, mechanics — not "best practices".
- **Two-source rule for numbers.** Any number that drives the recommendation needs a second independent
  confirmation or is labelled `[single source]`.
- **Observed vs. inferred.** Separate observed facts, interpretation, and hypothesis. If the evidence is
  insufficient, investigate further or make the uncertainty explicit; do not dress speculation as discovery.
- If the question collapses under research, do not salvage a dead premise. **Re-rank**: re-score the remaining
candidates against what the research just established (a finding that kills one premise often promotes
another), record that second table in `03-research.md`, and continue with the new winner. Only skip when no
candidate survives the re-rank. This is what the 2026-11-14 run lacked — it spent a whole run discovering the
first premise was dead and never re-scored the other four.

`$RUN/03-research.md` shape: **Question · What I found (3–6 bullets with links) · Counter-evidence ·
What this changes · Confidence (high/medium/low + why)**.

## Stage 5 — Publish or skip

Publish only if the rubric still holds after research. Write the note to `$RUN/04-note.md`, then:

```bash
$WORKSPACE/adapters/orbit/publish.sh \
  --slug <slug> --title "<title>" --description "<one line>" --category "<Growth|Systems|Strategy>" \
  --file "$RUN/04-note.md"
```

**How publishing actually works.** The script calls `orbit dispatch publish` (Orbit's object API) with an
idempotency key of `dispatch:<slug>`, then reads the dispatch back **through the authenticated CLI**
(`orbit dispatch show <slug> --json`) and exits non-zero unless id, slug, title and `status: published` all
match. It does not write Git, rebuild Astro, or deploy the Worker — the Worker reads `obj_*` at request time.
The public note URL is auth-gated (401 unauthenticated), so an HTTP 200 check is meaningless and must never be
claimed. If the read-back fails, the run is unpublished: report the failure, write the decision, announce
nothing.

Then record the run — this writes `05-decision.md` when it is missing and maintains `state/last-run.json`,
`state/runs.jsonl` and the rolling seven-day count:

```bash
adapters/orbit/state.sh record --run "$RUN" --outcome published --mode "<Mode>" --candidates <N> \
  --chosen "<winning question>" --score-initial <N> --score-final <N> \
  --research-changed <yes|no> --slug <slug> --dispatch-id <id> --title "<article title>"
```

Every run writes `05-decision.md`, including skips. Then update `seen-topics.md` (slug · status · date · note).

## Note format (300–500 words)

```
## What I noticed
<the specific recent work, named — a post, a commit, a session, a number>

## What I found
<the research, with links; mark hypotheses as hypotheses>

## Why it matters
<what it changes for your stated goal>

## Evidence
- Observed: <specific artifact, Work Map record, code path, workflow, metric, or configuration>
- Interpretation: <what the observation suggests>
- Hypothesis / uncertainty: <what remains unproven>

## What I'd do
<one clear implication or experiment; not a task list>
```

Title: a specific claim, never a subject ("Who already links to agent-loop write-ups — and why they'd link to
yours" beats "Backlink strategy"). No SEO, no CTA, no closing summary.

The note should teach you something he did not already know. It should not be a Work Map summary, a restatement
of the Intent Map, or a list of homework. Actionability is one implication, not a backlog.

## Idempotency

`state/last-run.json` (schema 2) holds the run's observability record: `date, mode, candidates_evaluated,
chosen_question, score_initial, score_final, research_changed_decision, outcome, skip_reason, slug,
dispatch_id, title, material_hash, published_7d`. `state/runs.jsonl` keeps one line per date (append-only
history) and is what the rolling seven-day count is computed from.

**Idempotency uses `material_hash`, never the whole-snapshot hash.** If today's material hash equals the last
run's **and** there is no new material evidence, write `04-skip.md` with `skipped — no material change since
<date>` and publish nothing. The hash is a hint, not a veto: if the material file contains genuinely new
evidence (a new post, a decision, a repeated failure), proceed anyway and say why in `00-understanding.md`.
Repeated runs must not manufacture notes, and must not suppress real ones.

## Dry run

`ORBIT_DRY_RUN=1` — run all stages, write every baton, print the note, publish nothing. `ORBIT_PUBLISH_DRY=1`
is the equivalent publish-script alias. Use for tests; use a test run directory and avoid mutating production state.
