---
name: iteration-planning
description: Interview Ivan about the next product/dev iteration, turn the discussion into a focused local iteration plan, validate it with local multi-agent review, and hand off to local implementation. Use when planning the next iteration, shaping work before implementation, or preparing a plan for delivery in this repo.
---

# Iteration Planning Interview

## Overview

Help Ivan turn an early idea into an implementation-ready iteration plan for this repository. Interview them, slice the work, write the plan in `docs/iterations/`, and validate the plan locally.

<HARD-GATE>
During planning, do not implement application code. Only edit planning artifacts, workflow/skill files, and acceptance/story artifacts when they are explicitly part of planning. This skill ends with a ready plan, a local review result, and the next command/skill to use for implementation.
</HARD-GATE>

## Checklist

Create a task for each item and complete them in order:

1. **Explore context** — read `README.md`, `user-stories.md`, `AGENTS.md`, existing code/tests as needed, and existing `docs/iterations/` plans.
2. **Interview Ivan** — ask one clarifying question at a time about goal, scope, acceptance criteria, business decisions, implementation shape, and validation.
3. **Size and slice** — keep each iteration to one shippable slice: one behaviour rule or one technical capability. Split larger ideas into sequential iterations.
4. **Present a draft** — summarize the goal, scope, acceptance criteria, plan shape, validation, and BDD/story decision; get Ivan's approval or corrections before writing the final plan.
5. **Write planning artifacts** — create `docs/iterations/<NNN>-<topic>/plan.md` and, when useful, supporting files such as `manual-demo-script.md` or `notes.md`. Maintain `docs/iterations/README.md` as the index.
6. **Write `todo.md`** — create `docs/iterations/<NNN>-<topic>/todo.md` with small Markdown checklist tasks derived from the implementation plan. Each task should be independently implementable and validated.
7. **Run local plan validation** — ask at least two available local agents to review the plan, or explain why multi-agent review was unavailable. Use `claude`, `gemini`, and `copilot` if installed. Synthesize their feedback yourself.
8. **Revise if needed** — if the synthesized decision is NOT READY, ask Ivan one question at a time, revise the plan/todo, and re-run targeted review.
9. **Commit planning artifacts only when Ivan asks** — by default, leave the plan in the working tree and report the path, status, validation result, and next step.

## Local Plan Validation

Use this review prompt with each available local agent. Run agents from the repo root and ask them not to edit files.

```text
You are independently reviewing an iteration plan before implementation.
Do not edit files. Read the plan and todo list, then return a Markdown report.

Review against:
1. Goal clarity and beneficiary.
2. Scope focus: one coherent outcome, smallest useful slice, clear non-goals.
3. Acceptance criteria and BDD/story decision: concrete, testable, relevant edge cases.
4. Implementation plan: ordered, specific, likely files/modules/tests named where useful.
5. Validation plan: how success will be proven and what the stop condition is.
6. Todo quality: tasks are small, ordered, plan-conforming, and independently checkable.

Return:
- Decision: READY or NOT READY
- Confidence: High, Medium, or Low
- Blocking gaps
- Non-blocking improvements
- Smallest viable iteration
- Required plan/todo edits
- Validation notes
```

Run each reviewer read-only. Write the prompt to a scratch file first; the flags stop a reviewer from editing even if it ignores the prompt.

```bash
PROMPT="$(cat "$SCRATCH/plan-review-prompt.txt")"
claude -p --allowedTools Read Glob Grep "Bash(git diff*)" "Bash(git status*)" -- "$PROMPT"
gemini -p "$PROMPT"   # default approval mode: no unattended writes
copilot -p "$PROMPT" --allow-tool='shell(git diff)' --allow-tool='shell(git status)' --deny-tool='write'
```

If a command is unavailable, slow, or interactive, skip it and record that in the validation notes. Do not let tool friction block planning when the plan is otherwise clear.

## Plan Format

```markdown
# <Iteration title>

Date: YYYY-MM-DD
Status: draft | ready | needs-revision

## Goal

## Background / Context

## Scope

### In scope

### Out of scope

## Iteration Type

Behaviour-facing or technical/engineering. For behaviour-facing iterations, identify the user-observable rule changed. For technical iterations, explain why no user-observable behaviour changes.

## Acceptance Scenarios / Story Coverage

State the BDD/story decision: `Required`, `Useful but not required`, or `Not useful for this slice`. Name any story, feature, or test files that express the rules, or explain why extra story artifacts would not help.

## Acceptance Criteria

## Open Business Decisions

## Implementation Plan

## Open Technical Decisions

## New Capability

What we expect to be able to do once this is done that we could not do before.

## Validation Plan

How we will validate success. For this repo, prefer focused Vitest tests plus `npm run checks` before completion.

## Risks / Follow-ups
```

## `todo.md` Format

```markdown
# <Iteration title> Todo

Plan: ./plan.md

- [ ] First small implementation task, including its focused validation.
- [ ] Next task.
- [ ] Final quality gate: run `npm run checks` and update the plan status if complete.
```

## Key Principles

- One question at a time.
- One iteration is one slice.
- Make decisions explicit.
- Make acceptance criteria testable.
- Validate locally.
