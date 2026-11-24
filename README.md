# Skills

Two agent skills I use daily, extracted so they can be read, forked, and linked to — instead of pasted
into a blog post.

- **[personal-strategist](skills/personal-strategist/)** — a daily strategic loop over your own project
  context. Reads a charter, generates candidate opportunities, ranks them with a hard rubric, researches
  the winner, publishes at most one note a day or nothing.
- **[research-engine](skills/research-engine/)** — a two-stage research loop. One process frames the
  question and writes a neutral brief; a second, isolated process researches it; a third scores the result
  and publishes only what clears the bar.

## The idea

Each skill is **procedure + references**. Everything personal — goals, paths, destinations, cadence,
volume caps — lives in a `config.yaml` you write, never in this repo. That is what makes them shareable,
and it is enforced by CI: no host paths, no names, no product names under `skills/**`.

## Set up for Orbit, portable without it

Both skills publish through an adapter:

- `orbit` — publish a note as an object, verify by read-back (the default in production use).
- `file` — write markdown into a directory. No platform required.
- `none` — draft only.

The `file` adapter is what the examples use, so you can run everything with nothing but a shell.
See [docs/orbit.md](docs/orbit.md).

## Quick start

```bash
cp skills/research-engine/config.example.yaml ~/.config/research-engine/config.yaml
export RESEARCH_LOOP=~/.local/share/research-engine
skills/research-engine/scripts/research-engine status
```

Each skill's `SKILL.md` carries the procedure; `references/` carries the long contracts
(the rubric, the stage briefs, the editorial anchors).

## Layout

```
skills/<name>/{SKILL.md,references/,scripts/,config.example.yaml,examples/}
adapters/{orbit,file}/
docs/{orbit.md,customizing.md,design-notes.md}
```

## Customizing

Read [docs/customizing.md](docs/customizing.md) first. Short version: change config and charter; do not
lower a rubric to make a run pass.

## License

MIT.
