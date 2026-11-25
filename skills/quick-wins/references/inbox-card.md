# Inbox card format

One card. Readable on a phone in under 20 seconds. The card is the approval surface; the `details` block is
the Work handoff.

```bash
orbit inbox send \
  --type decision \
  --title "<verb phrase: what changes>" \
  --summary "<one sentence: the opportunity>" \
  --text "<what the agent will do, in 2-3 short paragraphs max>" \
  --actions "Move to Work" --actions "Not now" \
  --id "qw-<date>-<slug>" \
  --source quick-wins \
  --details '{
    "why":   "<the Intent Map goal + the evidence that this is real>",
    "goal":  "<the outcome, one line>",
    "effort":"<agent effort> · <human effort>",
    "expected": "<what improves, and how it would be measured>",
    "next_steps": ["1. …", "2. …", "3. …"],
    "links": [{"label":"…","url":"…"}]
  }'
```

## Rules

- Title is the change, not the topic: "Give the Obsidian post a working signup CTA", not "Newsletter".
- Never put the rubric, the candidate list, or raw research in the card.
- Evidence lives in `details.why` and `details.links` — one line each, not a report.
- Say what the human must do in their own sentence. If it is more than one approval or one answer, the
  opportunity fails the attention floor and should not be sent.
