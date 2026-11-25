---
name: iteration-implementation
description: Implement the next unchecked task from a local docs/iterations/*/todo.md plan, using TDD and local validation. Use after iteration-planning, when Ivan asks to implement an iteration or continue the next todo item.
---

# Local Iteration Implementation

## Overview

Implement a planned iteration one small todo item at a time in the local checkout. `plan.md` is the source of truth; `todo.md` is execution state.

## Checklist

1. **Find the plan** — use the plan path Ivan gives, or the latest `docs/iterations/NNN-*/plan.md` if unambiguous. Derive `todo.md` from the same folder.
2. **Read before editing** — read `plan.md`, `todo.md`, `AGENTS.md`, and relevant code/tests/docs.
3. **Check working tree** — run `git status --short`. If unrelated uncommitted work exists, stop and ask before editing.
4. **Select one task** — pick the first unchecked Markdown task line (`- [ ] ...`) in `todo.md`. That task is yours until check-off.
5. **Implement only that task** — use TDD for behaviour changes. Do not opportunistically implement later tasks.
6. **Split if too large** — if the selected task is too large, replace it with smaller unchecked tasks in `todo.md`, then implement only the first new slice.
7. **Respect story artifacts** — do not edit `user-stories.md` or acceptance/story files unless the plan explicitly allows it.
8. **Run focused validation** — run the smallest useful test/check for the selected task. For this repo, prefer focused `vitest`/`tsc` commands, then `npm run checks` for final validation or broad-risk changes.
9. **Check off the exact task** — when implementation and focused validation pass, change the implemented line from `- [ ]` to `- [x]`. Do not check off other ordinary tasks.
10. **Report clearly** — summarize selected task, changes, validation, exact check-off, and remaining tasks.

## Binding Rules

- Earlier checked tasks are durable completed work. Do not redo them unless tests force a minimal correction.
- If uncommitted changes appear to be the selected task's in-progress work, you may continue only if you can do so without overwriting or discarding anything.
- You may add technical subtasks to `todo.md` only when required to satisfy the approved plan.
- You may not delete, weaken, or silently defer plan-required work.
- If you hit a real blocker, stop without checking off the task and report the blocker.

## Validation Guidance for This Repo

Useful commands:

```bash
npm test
npm run typecheck
npm run lint:fix
npm run format:fix
npm run checks
```

When there is no `justfile`, finish a completed iteration by running `npm run checks` so Ivan can demo/manual test immediately.

## Completion Summary Format

When finished, report:

1. Selected todo line and task text.
2. Code/config/test/doc changes made for this task only.
3. Focused validation commands run and results.
4. The exact todo check-off made.
5. Any todo splits/additions/reordering and why they still satisfy the plan.
6. Remaining unchecked tasks.
