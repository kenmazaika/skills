# Design notes

## Why the question and the research are separated

Stage A knows the charter — goals, history, what you wish were true. Stage B sees one neutral brief and
the open web. If Stage B could read the reasoning, it would research toward the conclusion the author
already wanted, and the citation list would be curated to support it.

`discovery.md` exists so the choice of question stays auditable without contaminating the research.

## Why an editorial gate at all

A research loop that publishes everything becomes a machine for generating plausible text. The gate is a
separate process with a weighted rubric, an explicit evidence floor, and a threshold that is not
negotiable inside the run. It is allowed to reject.

Expected outcome for a healthy loop: most days produce nothing publishable. That is not a bug report.

## Why the state is a file, not a queue

`state/questions.json` plus a lease is enough to make the loop resumable, inspectable, and boringly
reliable: one question per day, no double research, no duplicate dispatch, and a `reconcile` path for the
classic failure — the write succeeded and the acknowledgement did not.

## Why nothing personal lives here

A skill with someone else's paths and product names is not a skill, it is a screenshot. Everything
specific to a deployment lives in `config.yaml` and the charter, which means this repository can be
tested with synthetic data and read without knowing whose workflow it came from.
