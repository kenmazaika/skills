# Work handoff

Moving a recommendation to Work is the moment the agent stops guessing and starts executing. The Work item
must be an assignment, not a copy of the notification.

## What the handoff must carry

| Field | Why |
|---|---|
| **Opportunity + desired outcome** | what changes, stated as a result |
| **Goal it serves** | the Intent Map line this advances |
| **Work Map references** | the actual systems, paths, repos, URLs involved |
| **Supporting evidence** | what proved the opportunity is real |
| **Proposed approach** | enough that the executor does not rediscover the problem |
| **Constraints and dependencies** | credentials, approvals, people, timing |
| **Expected human involvement** | the one approval or answer, specified |
| **Authorization boundary** | what the agent may do without asking again |
| **Done criteria** | how completion and verification are judged |

## What it must not be

- A restatement of the card.
- A plan that requires the human to do the investigation.
- Blanket permission. The approval covers the stated outcome and scope, not external publication,
  spending, destructive changes, or third-party contact.

## Adapting during execution

If the executor learns the opportunity is invalid or the approach is wrong, it should say so and stop —
not execute something plausible to justify the handoff.
