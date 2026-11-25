---
title: Home
layout: home
nav_order: 1
---

# {{ site.title }}
{: .no_toc }

{{ site.description }}.
{: .fs-6 .fw-300 }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## RPG Combat

RPG Combat is a programming kata: a small rules engine for characters that deal damage, heal, level up, join
factions, and use magical objects. The rules arrive as incremental user stories, and each one adds constraints that
push the design forward. This project implements them in TypeScript.

Read the full rules in [user-stories.md]({{ site.repository }}/blob/main/user-stories.md).

### Origins of the kata

The kata was invented by Daniel Ojeda Loisel, who first published it as a
[slide deck](https://www.slideshare.net/DanielOjedaLoisel/rpg-combat-kata). Steve Smith later wrote it up in his
[kata catalog](https://github.com/ardalis/kata-catalog/blob/main/katas/RPG%20Combat.md), and the
[Samman Coaching Society](https://sammancoaching.org/kata_descriptions/rpg_combat.html) adapted that description into
the version used by coaches today. This project follows the Samman rules and starts from its template.

## Matt Wynne's software factory

Matt Wynne built the kata with a software factory on the
[`factory` branch of his fork](https://github.com/mattwynne/rpg-combat/tree/factory), and introduces the idea in
[Don't fear the Dark Factory](https://mattwynne.net/dont-fear-the-dark-factory). In his repository:

- A **Ralph loop** runs a coding agent over the current iteration's todo list, committing each successful run, until
  no unchecked tasks remain.
- An **ensemble review** asks several coding agents for a refactoring review at the end of each iteration, and their
  findings become new todo items for the loop.
- **Kaizen notes** record friction in the factory itself, kept apart from product work.

This project reimplements that approach from the Samman template, with Claude Code running the Ralph loop in place of
Codex. For more sources, see [Origins of the approach]({{ site.baseurl }}/software-factory/explanation/origins/).

## Project Goals 🎯

1. **Test Matt Wynne's approach** to building a software factory while solving the RPG Combat kata.
2. **Learn software factory and dark factory concepts**: what a
   [software factory]({{ site.baseurl }}/software-factory/reference/glossary/#software-factory) is, and what it
   takes to run it as a [dark factory]({{ site.baseurl }}/software-factory/reference/glossary/#dark-factory).
3. **Document the practice**: capture how the factory works so it can be reused on other projects.

## Where to go next

- [Software Factory]({{ site.baseurl }}/software-factory/software-factory/) — how the agent-driven workflow is set up and used.
- [Blog]({{ site.baseurl }}/blog/) — engineering notes and project updates.
