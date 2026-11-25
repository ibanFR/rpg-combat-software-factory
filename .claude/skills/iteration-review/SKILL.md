---
name: iteration-review
description: Run a local multi-agent review of an implemented iteration, synthesize the findings, apply bounded safe refactors, and prepare the iteration for Ivan's review. Use after implementation tasks are complete or when Ivan asks for review/refactor.
---

# Local Iteration Review and Refactor

## Overview

Review a completed local iteration. Use local checks plus independent local agent reviews where available. Synthesize findings, apply only bounded safe fixes, and leave judgement calls for Ivan.

## Checklist

1. **Read context** — read the iteration `plan.md`, `todo.md`, touched files, and recent diff/commits.
2. **Check completion** — verify every ordinary task in `todo.md` is checked, or clearly identify remaining work.
3. **Run the quality gate** — run `npm run checks` before review unless Ivan explicitly asks for a partial review.
4. **Collect review context** — capture `git status --short`, `git diff --stat`, and relevant diffs.
5. **Run local multi-agent review** — ask at least two available local agents to review without editing, or record why unavailable. Prefer `claude`, `gemini`, and `copilot` when installed.
6. **Synthesize** — decide `ACCEPT`, `FIX`, or `HUMAN_INPUT`.
7. **Apply bounded-safe fixes only** — if synthesis says `FIX`, make concrete low-risk refactors/convention/test-quality fixes that do not change product behaviour or story artifacts. Re-run focused checks and then `npm run checks`.
8. **Repeat once if needed** — after fixes, re-run targeted review or self-review. If the same blocker remains, stop and ask Ivan rather than looping.
9. **Update plan status** — if accepted and the validation gate passes, update `plan.md` status to `ready` or `done` according to the plan's convention.
10. **Report** — summarize validation, review decision, fixes applied, remaining risks, and exact files changed.

## Local Review Prompt

Use this prompt with each available local agent. Run agents from repo root and instruct them not to edit files.

```text
You are independently reviewing a completed implementation for the iteration plan below.
Do not edit files. Review the current working tree and return a Markdown report.

Review against:
1. Plan fidelity: implementation satisfies the stated goal, scope, acceptance criteria, and todo list.
2. Behaviour and coverage: important happy paths, edge cases, errors, and state changes are covered by automated tests where appropriate.
3. Technical quality: TypeScript, Vitest, ESLint, Prettier, module boundaries, naming, and maintainability.
4. Minimality: no obvious out-of-scope work or unnecessary complexity.
5. Refactoring opportunities: distinguish bounded safe fixes from judgement-worthy design concerns.

Return:
- Decision: ACCEPT or REJECT
- Confidence: High, Medium, or Low
- Blocking issues
- Bounded-safe fixes
- Judgement-worthy non-blocking findings
- Suggested fixes
- Validation notes
```

Run each reviewer read-only. Write the prompt to a scratch file first; the flags stop a reviewer from editing even if it ignores the prompt.

```bash
PROMPT="$(cat "$SCRATCH/iteration-review-prompt.txt")"
claude -p --allowedTools Read Glob Grep "Bash(git diff*)" "Bash(git status*)" -- "$PROMPT"
gemini -p "$PROMPT"   # default approval mode: no unattended writes
copilot -p "$PROMPT" --allow-tool='shell(git diff)' --allow-tool='shell(git status)' --deny-tool='write'
```

If a tool is unavailable, slow, or interactive, skip it and record that.

## Synthesis Rules

- **ACCEPT** only if `npm run checks` passed, plan/todo are complete, and no unresolved blocking issues remain.
- **FIX** for bounded safe changes an agent can make locally without changing product behaviour or acceptance/story artifacts.
- **HUMAN_INPUT** for unclear acceptance criteria, product decisions, architecture choices outside the plan, repeated blockers, or conflicting review findings.
- Do not edit `user-stories.md` or other story artifacts during review unless the plan explicitly allowed it.

## Completion Summary Format

Report:

1. Plan path and todo status.
2. Quality gate command/result.
3. Agents consulted and any skipped tools.
4. Synthesis decision.
5. Fixes applied, if any, and validation after fixes.
6. Judgement-worthy findings for Ivan.
7. Files changed during review.
