# RPG Combat Software Factory

An implementation of the RPG Combat kata, built by a software factory of coding agents. The project exists to test and learn how such a factory works.

## Language

### Factory

**Software factory**:
Coding agents that work on their own toward a desired outcome, with a built-in validation loop that checks their output against what done means and feeds findings back.
_Avoid_: Agentic software factory, agent pipeline, AI workflow

**Dark factory**:
A software factory run lights-out: no human writes or reviews the code; humans set intent and judge outcomes.
_Avoid_: Lights-out factory, autonomous factory

**Operator**:
The human who shapes iterations, answers blocking questions, and accepts or rejects reviewed work.
_Avoid_: User, product owner

**Iteration**:
One shippable slice of product behaviour (one rule or one capability), with its own plan and todo list.
_Avoid_: Wave, sprint, story

**Todo**:
One small, independently checkable task in an iteration's todo list, checked off only once validated.
_Avoid_: Step, subtask

**Ralph loop**:
The software factory's main loop: an agent session runs repeatedly over the current iteration's todo list until no unchecked tasks remain or progress stops, with each successful run committed.
_Avoid_: Agent loop, autopilot

**Ensemble review**:
A refactoring review run by several different coding agents at the end of an iteration, whose combined findings become new todo items for the Ralph loop.
_Avoid_: Mob review, multi-agent review

**Kaizen note**:
A recorded observation of friction in the factory itself (workflow, tooling, prompts) together with its fix, kept apart from product work.
_Avoid_: Retro note, improvement log

## Relationships

- An **Iteration** has one or more **Todos**; one **Ralph loop** run completes at most one **Todo**
- The **Operator** approves an **Iteration** plan before the **Ralph loop** runs it
- A **Kaizen note** changes the factory, never product behaviour; an **Iteration** changes product behaviour, never the factory

## Flagged ambiguities

- "Wave" belongs to nWave, which this repo uses only for Diataxis documentation; it is not an **Iteration**.
