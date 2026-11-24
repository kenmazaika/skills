# Customizing

## The line to respect

**Change the config and the charter. Leave the rubrics alone.**

| Layer | Where | Change it when |
|---|---|---|
| Charter | `charter.goals`, `charter.intent_map`, `charter.work_map` | your goals or systems change |
| Config | `~/.config/<skill>/config.yaml` | cadence, volume, destinations, thresholds |
| Procedure | `skills/*/SKILL.md` | you are improving the method itself (send a PR) |
| Rubric | `skills/*/references/rubric.md` | almost never — see below |

A rubric edited to fit today's situation stops measuring anything. If a run keeps failing the gate, the
likely fixes are a sharper charter or a better candidate, not a lower bar.

## Adding a skill

1. `skills/<name>/SKILL.md` with frontmatter (`name`, `description`, `version`, `license`).
2. `references/` for anything long enough to be skipped in a hurry.
3. `config.example.yaml` — the only personal surface.
4. No host paths, no names, no product names. CI enforces this.

## Adapting the charter

The charter is three files, and they answer different questions:

- **goals** — what you are trying to accomplish, in your words.
- **intent map** — why the work exists; what the agent may question and must preserve.
- **work map** — what actually exists, with a state (`live`, `degraded`, `broken`, `stale`, `unverified`)
  and a verification date.

If you only have one file, point all three keys at it. The skills degrades gracefully; they do not
require three documents, they require an answer to "what matters" and "what exists".
