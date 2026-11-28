**ALWAYS** start replies with ⚔️.

## What this project is

An implementation of the RPG Combat rules engine. There are six user stories described in [user-stories.md](user-stories.md)

## Product vs factory work

- Product behaviour work for RPG Combat belongs in `docs/iterations/`.
- Factory/workflow/tooling problems belong in `docs/kaizen/`.
- Do not create product iteration plans for Ralph loop scripts/prompts, Claude skills/prompts, planning/review handoffs, validation, or process improvements.
- If factory friction is noticed during product work, capture it as a Kaizen note (`kaizen-note` skill) instead of folding it into the product iteration.

## Build and Test Scripts

- `npm test`: runs unit tests using vitest
- `npm run lint:fix`: runs eslint with autofix
- `npm run format:fix`: runs prettier with autofix
- `npm run typecheck`: runs tsc without emit
- `npm run checks`: runs the pre-commit gate (format:fix, lint:fix, typecheck, test)

## Agent skills

### Issue tracker

Issues are tracked in this repo's GitHub Issues, managed with the `gh` CLI. See `docs/agents/issue-tracker.md`.

### Triage labels

Uses the five default triage roles, each label named after its role. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: one `CONTEXT.md` and `docs/adr/` at the repo root. See `docs/agents/domain.md`.
