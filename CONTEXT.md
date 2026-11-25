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

**Ralph loop**:
The software factory's main loop: an agent session runs repeatedly over the current iteration's todo list until no unchecked tasks remain or progress stops, with each successful run committed.
_Avoid_: Agent loop, autopilot

**Ensemble review**:
A refactoring review run by several different coding agents at the end of an iteration, whose combined findings become new todo items for the Ralph loop.
_Avoid_: Mob review, multi-agent review

**Kaizen note**:
A recorded observation of friction in the factory itself (workflow, tooling, prompts) together with its fix, kept apart from product work.
_Avoid_: Retro note, improvement log
