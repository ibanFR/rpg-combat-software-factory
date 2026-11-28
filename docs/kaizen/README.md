# Kaizen notes

A **Kaizen note** (see `CONTEXT.md`) records friction in the factory itself: the Ralph loop, prompts, skills, validation, handoffs. It records the problem, not the fix; it stays open until it gains a **Resolution**. Product behaviour never changes here; that belongs in `docs/iterations/`.

- Record a note with the `kaizen-note` skill (`.claude/skills/kaizen-note/`). It holds the note template.
- Resolve a note with the `kaizen-fix` skill (`.claude/skills/kaizen-fix/`). It appends the `## Resolution` section.
- The Ralph loop never writes notes. It reports factory friction in its run output, and the Operator records it.
