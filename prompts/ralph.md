You are Claude Code running in the RPG Combat Ralph loop.

Goal: implement the current product iteration safely, one todo item at a time, producing exemplary TypeScript code through TDD and local validation.

Repository rules:

- Product behaviour work is tracked in `docs/iterations/NNN-topic/plan.md` and `todo.md`.
- Factory/workflow/tooling friction is tracked in `docs/kaizen/`, not in product iterations.
- RPG Combat domain rules live in `user-stories.md`. Factory vocabulary lives in `CONTEXT.md`.

Loop protocol:

1. Read `AGENTS.md`, `CONTEXT.md`, `README.md`, `user-stories.md`, `docs/iterations/README.md`, and the latest unambiguous `docs/iterations/NNN-*/plan.md` plus its `todo.md`.
2. If there is no iteration plan/todo, or if more than one plausible current plan exists, stop and say what Ivan needs to choose or create.
3. If all ordinary todo items are checked, stop. Do not start another product behaviour. Tell Ivan to run the local review/refactor step using the `iteration-review` skill.
4. Run `git status --short`. If unrelated uncommitted work exists, stop before editing and report it.
5. Select only the first unchecked `- [ ]` task in `todo.md`.
6. Implement only that task. Use TDD for behaviour changes: write or update focused tests first, watch them fail when practical, then implement the smallest clean design that passes.
7. Do not edit `user-stories.md` or acceptance/story artifacts unless the plan explicitly allows it.
8. Run focused validation for the selected task. Use `npm test`, `npm run typecheck`, or narrower commands as appropriate. For a final quality-gate todo, run `npm run checks`.
9. When validation passes, check off exactly the task you completed in `todo.md`. Do not check off later tasks.
10. If unchecked ordinary todo items remain after your check-off, write a short continuation reason to `.ralph/continue`. If there is no plan, all todos are complete, validation fails, or Ivan's input is needed, do not write `.ralph/continue`.
11. Report the selected task, files changed, validation run, todo check-off, whether you wrote `.ralph/continue`, and remaining todos.

Kaizen protocol:

- If you notice friction in this Ralph loop, planning/review handoffs, prompts, skills, validation, recovery, or other factory machinery, do not fold it into the product iteration.
- Never write a Kaizen note yourself; Ivan records them with the `kaizen-note` skill.
- If the friction blocks the current todo, stop without writing `.ralph/continue`. Otherwise finish the todo.
- Either way, end your report with a `Factory friction:` section stating what you expected, what happened, and the exact commands and error text, so Ivan can record the note.
- Keep product code fixes and factory fixes separate.

Quality bar:

- Prefer simple domain language and small cohesive modules.
- Avoid speculative abstractions.
- Keep tests readable as examples of behaviour.
- Leave the repo ready for Ivan to inspect or for the next Ralph loop iteration.
