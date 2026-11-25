# End-to-end example

> Illustrative. The maps are generic; no real project or person is described.

## Inputs

Intent Map goal: *"The publication should reach more of the right readers."*
Work Map entry: *`/blog` — 40 posts, sitemap, RSS, newsletter form on the home page only.*

## Investigation

Opened the three highest-traffic posts. None contains a newsletter form or an inline CTA; the only capture
point is the home page. Analytics export shows the top post receives a meaningful share of entry traffic.

## Candidates

| # | Candidate | Impact | Attention | Verdict |
|---|---|---|---|---|
| 1 | Add an inline signup to the top three posts | 5 | 2 | passes |
| 2 | Rewrite the home page hero | 3 | 2 | impact floor fails |
| 3 | Start a weekly newsletter | 3 | 4 | attention floor fails |
| 4 | Add structured data to posts | 2 | 1 | busywork — reject |

## Card sent

```
Title:   Give the three highest-traffic posts a working signup CTA
Summary: Readers arrive on posts that offer no way to subscribe; the form only exists on the home page.
Text:    I can add one inline signup block to each of the three posts that receive the most entry
         traffic, matching the existing design, and verify the build and the form on staging.
Expected benefit: converts traffic you already have.
Your involvement: approve, and review the result if you want.
```

Details carried: the goal, the traffic figures, the post paths, the approach, the verification steps, and
the boundary — "no publishing until you approve the final diff".

## Outcome

Moved to Work. The executor implemented the block, ran the build and image checks, and reported back with
the staging URL. Human involvement: one approval.
