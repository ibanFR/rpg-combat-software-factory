---
title: Origins of the approach
layout: default
parent: Explanation
grand_parent: Software Factory
nav_order: 1
---

# Origins of the approach
{: .no_toc }

Where the software factory and dark factory ideas behind this project come from.
{: .fs-6 .fw-300 }

This project tests the approach [Matt Wynne](https://mattwynne.net/) has written and spoken about through 2026. The
sources below are the ones worth reading to understand it, roughly in the order they build on each other.

## Matt Wynne's writing and talks

- [Don't fear the Dark Factory](https://mattwynne.net/dont-fear-the-dark-factory) (blog post, May 2026). His main
  introduction: a dark software factory is a simple loop of agent sessions. A good validation harness plus a
  good-quality seed input makes non-deterministic agents converge on the outcome you want. Introduces Ralph loops.
- [Lean Software Production](https://mattwynne.net/lean-software-production) (blog post, May 2026). Frames the wider
  practice as lean thinking (kaizen, Jidoka, pull-based flow) plus XP practices, applied to engineering the system that
  produces the code rather than crafting each line.
- [How to Move from Prompt Engineering to Harness Engineering in Testing](https://testguild.com/podcast/a596-matt/)
  (TestGuild Automation Podcast, episode 596, July 2026). A conversation about harness engineering, reviewing agent
  pull requests with several models, and a week spent with a team whose humans neither wrote nor read the code.
- [What is a Software Factory?](https://maven.com/p/70dd09) (free live lesson on Maven, September 2026). Defines
  software factories and dark factories, gives a taxonomy of factories, and demos open-source factory tooling.
- [What Is a Software Factory?](https://leansoftware.ai/blog/what-is-a-software-factory/) (blog post, November 2026).
  His definition: several agents with a built-in validation loop working on their own toward a desired outcome, where
  a validator checks a doer's output against what done means and feeds findings back.

## The reference implementation

- [mattwynne/rpg-combat, `factory` branch](https://github.com/mattwynne/rpg-combat/tree/factory). The RPG Combat kata
  built by a Ralph loop running Codex over each iteration's todo list, with an ensemble review by several coding agents
  at the end of each iteration and kaizen notes for friction in the factory itself. This project reimplements that
  approach with Claude Code running the Ralph loop.

## Where the term comes from

- [StrongDM's software factory](https://factory.strongdm.ai/). The dark factory work Matt Wynne links to when he first
  uses the term.

See the [Glossary]({{ site.baseurl }}/software-factory/reference/glossary/) for how this project defines each term.
