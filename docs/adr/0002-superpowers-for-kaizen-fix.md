---
status: accepted
---

# Enable the superpowers plugin for the project, but not for the Ralph loop

The `kaizen-fix` skill, ported from Matt Wynne's factory, tells the agent to load `/systematic-debugging` before proposing any fix to a **Kaizen note**. That skill is not Matt's: it ships in Jesse Vincent's `superpowers` plugin (`obra/superpowers`, MIT, listed in the `claude-plugins-official` marketplace). We keep the dependency, referenced as `superpowers:systematic-debugging`, and enable the plugin for everyone in `.claude/settings.json` so the dependency is recorded in the repo rather than in one person's machine. `bin/ralph` turns the plugin off for its own runs, because superpowers' `SessionStart` hook injects its whole `using-superpowers` skill into every session (marked `EXTREMELY_IMPORTANT`), and the **Ralph loop** must not have its behaviour changed by a plugin that exists only to serve `kaizen-fix`, which the **Operator** runs.

## Considered Options

- **Project scope, Ralph opts out (proposed)**: dependency is explicit and shared; Operator sessions get Matt's debugging method; Ralph runs unchanged. Cost: every Operator session in this repo also gets the injected superpowers workflow, and `bin/ralph` carries a `--settings` override that must name the plugin exactly.
- **Project scope, Ralph included**: simplest config, but Ralph's prompt would compete with superpowers' instructions, so a change in Ralph's behaviour could no longer be traced to `prompt.md` alone. That undermines what the factory experiment is meant to measure.
- **User scope only**: no repo change, but the dependency is invisible; a fresh clone runs `kaizen-fix` against a skill that does not exist.
- **Vendor `systematic-debugging` into `.claude/skills/`**: no hook, version pinned, no plugin at all. Cost: a copy that drifts from upstream, MIT attribution to carry, and a departure from referencing the skill the way Matt's factory does.
- **Swap in an installed equivalent (`mattpocock-skills:diagnosing-bugs`)**: no new dependency, but changes Matt's investigation method, which weakens the port as a faithful replay of his factory.

## Consequences

- Operator sessions start with superpowers' workflow guidance (brainstorm-first, plans, TDD skills) as well as this repo's own skills; conflicts between them are factory friction and belong in a **Kaizen note**.
- The plugin is unpinned: an upstream change to `systematic-debugging` or to the hook changes our factory without a commit here.
- If `kaizen-fix` is ever run inside the Ralph loop, the skill it depends on will be missing by design.
