# 06.03 · Stage A — Strategic question discovery

**Cron:** `0 1 * * *` America/Los_Angeles · isolated session · timeout 3600 s
**Job:** produce **at most one** durable, self-contained research question and mark it `ready`.
**Never:** create an Orbit card, ask for approval, wait for a human, write a task, or research the answer.

## 1 · Read (fresh each run — never copy contents into a prompt)

1. `02 - AREAS/02.08 - intent-map/Intent Map.md` — goals, beliefs, constraints.
2. `02 - AREAS/02.09 - work-map/INDEX.md` + `SYSTEM-OVERVIEW.md` + the last ~10 entries of `CHANGELOG.md`.
   Progressive disclosure: open only the 2–4 records the question actually needs.
3. Research history:
   - `bin/research-engine list` (lifecycle of every new-style question),
   - `questions/INDEX.md` and `questions/*.md` (legacy questions),
   - `03 - PERMANENT/03.01 - concepts/` (durable answers — do not re-ask what is answered),
   - `ledger.md` (which questions were killed and why).
4. Recent dispatches: `orbit dispatch list --json | head -40`, and the last 7 days of `log.md`.
5. External signal (one or two scans, not a survey): what changed recently in AI-agent tooling,
   distribution, or the business models adjacent to your work that could date an assumption.

## 2 · Generate ~5 candidates (internal, not written to the brief)

Draw from: unvalidated assumptions · strategic uncertainties · overlooked opportunities · emerging
technologies/approaches · comparable products or businesses · empirical evidence that challenges current
thinking · unexplored relationships between existing projects · distribution / product / technical /
audience questions.

A question may be valuable without being immediately actionable. **Do not** limit to the task backlog.

## 3 · Score every candidate (1–5 each)

| # | Criterion | Test |
|---|---|---|
| 1 | Strategic relevance | Would the answer matter given the actual goals? |
| 2 | Researchability | Can credible evidence be gathered? |
| 3 | Information gain | Is there something substantial not already known? |
| 4 | Consequence | Could it change thinking, priorities, or approach? |
| 5 | Originality | Meaningfully different from previous research? |
| 6 | Specificity | Bounded enough to produce a useful answer? |

Select **at most one**. If none clears (all six ≥ 4), write `runs/<date>/stage-a/none.md` with the candidate
table and stop — no ledger entry, no question file. Never manufacture novelty by rewording an answered
question.

## 4 · Write two files

`runs/<date>/stage-a/brief.md` — **the only thing the researcher will see**:

```markdown
# <Question title>

**Question ID:** <filled by the CLI output>  ·  **Created:** <YYYY-MM-DD>

## Question

<One self-contained question. No references to your goals, projects, intent map, or internal jargon
unless defined here. A competent outside researcher with no vault access must be able to act on it.>

## Definitions and scope

<Neutral definitions, the population/context being studied, time window, and what is explicitly out of
scope. Just enough to make the question unambiguous — no hints about the expected answer.>

## What a useful answer looks like

<2–4 neutral bullet points on the form of a good answer (e.g. "a quantified comparison", "evidence for and
against", "conditions under which each explanation holds"). No hypotheses.>
```

`runs/<date>/stage-a/discovery.md` — **audit only, never shown to the researcher**:

```markdown
# Discovery metadata — <title>

## Why this question
## Relationship to goals and projects (cite Intent Map sections / Work Map records by path)
## Candidates considered
| # | Candidate | Rel | Res | Gain | Cons | Orig | Spec | Total |
## Selection rubric scores for the winner (1–5 each, with one line of justification)
## Relevant strategic uncertainties
## Potential implications
## Preliminary hypotheses
## What would make this question wrong to have asked
```

Then:

```bash
bin/research-engine create --title "<title>" \
  --question-file "runs/<date>/stage-a/brief.md" \
  --discovery-file "runs/<date>/stage-a/discovery.md" --slug "<kebab-slug>"
```

Record the printed ID back into `brief.md` (question ID line) and append one line to `log.md` and today's
daily note. Commit the vault.

## 5 · Rules

- One question per day maximum; zero is a valid, successful run.
- The brief must survive on its own: if it needs the discovery file, rewrite it.
- No Orbit card, no Inbox note, no `00.01`, no `INBOX.md` mirror.
- Follow the Vault Voice Guide: short, concrete, no filler.
