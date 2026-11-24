# 06.03 · Stage B — Independent research

**Cron:** `15 2 * * *` America/Los_Angeles · **fresh isolated session** · timeout 3600 s
**Job:** answer the question in the brief as an independent researcher, persist the research, then hand it to
the editorial gate.

## Allowed inputs (this is the isolation boundary)

Read **only**:

1. `questions/<id>/brief.md` — the absolute path printed by `bin/research-engine claim`.
2. This file (`stage-b.md`) and `editor.md` (so you know what comes next).
3. Live web sources (`web_search`, `web_fetch`).

**Do not open:** `discovery.md`, `LOOP.md`, the Intent Map, the Work Map, `ledger.md`, previous runs, or the
question generator's notes. If a tool result surfaces them, ignore the content. You are answering a question
for an anonymous client — not optimising for anyone's expectations.

## 1 · Claim the question

```bash
bin/research-engine claim --wait 2700 --json
```

- `--wait 2700` polls for up to 45 minutes if Stage A is running late. Do not sleep manually.
- Exit code **2** = no qualifying question today → write `runs/<date>/stage-b/00-none.md`
  (`no qualifying question from Stage A`) and stop. This is a successful quiet run.
- Any other non-zero exit = operational failure → record it (see §5) and exit non-zero.

The JSON gives `id`, `brief`, `dir`, `run`, `attempt`.

## 2 · Research

Work the question like a journalist with a deadline and a sceptical editor.

- **Plan first.** Write `runs/<date>/stage-b/01-plan.md`: 4–7 lines — sub-questions, what evidence would
  settle each, where it likely lives, what would falsify the emerging answer.
- **Search widely, read primary.** Prefer the actual paper, filing, pricing page, repo, changelog, dataset,
  or documentation over commentary about it. Use secondary sources for orientation only.
- **Seek contradiction.** Actively look for evidence against the emerging answer and for competing
  explanations. Record what you find even when it is inconvenient.
- **Go one level deeper than the first page of results.** Follow the interesting thread; the value is in the
  thing a superficial summary would miss.
- **Separate what is known from what is inferred.** Label speculation as speculation. If the question cannot
  be answered confidently with available evidence, say so — that is a legitimate finding, and often the most
  useful one.
- **Never fabricate.** No invented sources, numbers, quotes, or studies. A missing source is data.

Aim for depth: 8–20 substantive sources is normal; a 3-result summary is not research.

## 3 · Write the research record

`runs/<date>/stage-b/02-research.md`, then copy it into the question folder:

```bash
bin/research-engine complete --id <id> --research-file "runs/<date>/stage-b/02-research.md"
```

Shape:

```markdown
# Research — <question title>

**Question ID:** <id> · **Completed:** <date>

## Question
<verbatim from the brief>

## Direct answer
<3–8 sentences. The best answer the evidence supports, with its confidence level stated.>

## Significant findings
<6–12 findings. Each: the claim, the evidence, the source.>

## Evidence
<Per finding: URL + what it establishes. Primary sources flagged as primary.>

## Counter-evidence and competing explanations
<What argues against the answer; which alternative explanations survive.>

## Limitations and unresolved uncertainties
<What could not be established, and why. Sample problems, paywalls, missing data, conflicting sources.>

## Sources
<Numbered list, full URLs.>

## Confidence
<Low / medium / high, with one line of reasoning per level.>
```

This document must stand alone: useful to a reader who never sees the brief or the editorial notes.

## 4 · Then (and only then) the editorial gate

The research is now persisted. Spawn the editor as a **separate subagent** with `sessions_spawn` so it gets
its own context, and give it the paths listed in `editor.md`. The editor may read the Intent Map, Work Map,
`discovery.md` and the research — that is the point of the separation.

Follow `editor.md` for the rubric, the threshold, and the publish/reject decision.

## 5 · Failure handling

- Research blocked or tool error: retry a step at most **twice**, then either finish with an honest
  `Confidence: low` section naming the gap, or `bin/research-engine fail --id <id> --reason "<what>"`.
- Never leave a question `researching` without a claim lease (6 h). A later run reaps it automatically.
- Operational failures are the only thing announced (Discord, short). A rejection or a no-question day is
  silent.

## Rules

- One question per run. No subagent fan-out for the research itself.
- No approval, no inbox card, no task creation.
- The only external write allowed is publishing a qualifying **private Dispatch** through
  `adapters/orbit/publish.sh`, as instructed by `editor.md`. No public blog, outreach, email, or purchase.
