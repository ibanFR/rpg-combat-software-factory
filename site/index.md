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
factions, and use magical objects. The rules are delivered as incremental user stories, each one adding constraints
that push the design forward.

Read the full rules in [user-stories.md]({{ site.repository }}/blob/main/user-stories.md).

## Project Goals 🎯

1. **Implement the RPG Combat rules engine** in TypeScript, test-first, one user story at a time.
2. **Build a software factory**: customize coding agents with instructions, skills, and workflows so that
   issues flow from triage to tested, reviewed code with as little friction as possible.
3. **Document the practice**: capture how the factory works so it can be reused on other projects.

## Where to go next

- [Software Factory]({{ site.baseurl }}/software-factory/software-factory/) — how the agent-driven workflow is set up and used.
- [Blog]({{ site.baseurl }}/blog/) — engineering notes and project updates.
