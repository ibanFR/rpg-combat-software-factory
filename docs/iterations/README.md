# Iterations

This directory holds local iteration plans for the RPG Combat repo.

## Local workflow

1. **Plan** — ask Claude Code to use the `iteration-planning` skill.
   - Output: `docs/iterations/NNN-topic/plan.md` and `todo.md`.
   - Validation: local multi-agent plan review (`claude`, `gemini`, `copilot`), synthesized by Claude Code.
2. **Implement** — ask Claude Code to use the `iteration-implementation` skill with the plan path.
   - Each run implements the first unchecked `todo.md` item only.
   - Each completed item is validated and checked off.
3. **Review/refactor** — ask Claude Code to use the `iteration-review` skill.
   - Runs `npm run checks`.
   - Runs local multi-agent code review.
   - Applies bounded safe refactors, then leaves judgement calls for Ivan.

Everything runs in the local checkout on the current branch.

## Index

_No iterations yet._
