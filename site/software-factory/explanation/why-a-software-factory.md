---
title: Why a Software Factory
layout: default
parent: Explanation
grand_parent: Software Factory
nav_order: 1
---

# Why a Software Factory
{: .no_toc }

This page explains what the software factory in this repository is, where the idea comes from, and why it is built this way.
{: .fs-6 .fw-300 }

## Table of Contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## What the factory is here

This repository defines the software factory as the set of coding agents, instructions, skills, and workflows that turn issues into tested, reviewed code.

The factory is not a product. It is the setup around the work. It includes the files an agent reads first. It includes the skills an agent can load. It also includes the issue queue and the checks that say when work is done.

People build and maintain this setup. Agents do the work inside it. The project has two other goals. It aims to cut friction from issue to reviewed code. It also aims to write the practice down, so other projects can reuse it.

Much of the factory is still a plan. The [current state](#current-state-what-exists-and-what-is-planned) section lists what exists.

## Where the term comes from

The phrase is older than coding agents. Cusumano's history of software factories credits R. W. Bemer, an engineer at General Electric, with an early proposal around 1968. The aim was to make output less uneven from one programmer to the next.

We know this claim only from a search snippet of Cusumano's history. We did not read the full text. Our confidence is medium-low. Treat it as a lead, not a settled fact.

[Cusumano's 1991 book](https://academic.oup.com/book/52424) covers Japanese software factories, process discipline, and quality control. We know its content only from catalog abstracts and reviews, not from reading it. This page cites it as background only.

In 2004, Microsoft published Greenfield and Short's work on software factories. Greenfield argued that the next step is to "move from documentation to automation." Know-how becomes reusable assets. He also said development should not become a mechanical process "tended by drones." See [Greenfield's 2004 article](https://learn.microsoft.com/en-us/previous-versions/aa480032(v=msdn.10)).

Since about 2025, the phrase also names agent pipelines. Most of that usage comes from vendors. No single meaning is agreed. This project uses the word in a more modest way.

### What carries over and what changes

| Question | 2004 software factories | Agent factory in this repository |
|---|---|---|
| Where know-how lives | Generators, frameworks, modeling tools | AGENTS.md and docs/agents. None of the skills are checked in; location not verified |
| What does the work | Deterministic code generation | An agent that follows natural-language instructions |
| How quality is checked | Generated code is correct by design | `npm run checks` is instructed, not enforced. CI builds the site and checks action pins. Human review |
| What people do | Skilled developers avoid rote work | Triage, specify, review, and decide what merges |

The biggest change is the worker. A generator gives the same output for the same input. An agent does not. So checks and human decisions carry more weight.

## Why practice is written as instructions and skills

An agent works better with the right context. Instruction files and skills give it that context.

[AGENTS.md](https://agents.md/) is an open format. Its authors call it a README for agents. A human README explains a project to people. AGENTS.md adds what an agent needs: build steps, tests, and conventions. Many coding tools read it. When files are nested, the nearest one applies.

Context is limited. Anthropic's engineering guidance says context "must be treated as a finite resource with diminishing marginal returns." So the always-loaded file stays short. Details go in other files. Those files are read only when needed.

Skills follow the same idea. The [Agent Skills documentation](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) describes progressive disclosure. A short description is always visible. The full body loads only when a task needs it.

In this repository, AGENTS.md is short. It points to three adapter files in docs/agents. Those files tell skills how to find this repository's issue tracker, labels, and domain docs. Details belong in reference pages, not here.

Every instruction must be kept up to date. That has a cost. The trade-offs section returns to it.

## Why triage and a delegation decision

Triage is where a person decides what an agent may do. The repository adopts five triage roles from the mattpocock/skills project. Two of them matter most here.

- `ready-for-agent`: fully specified, ready for an AFK agent.
- `ready-for-human`: a person must do the work.

In our reading, AFK means "away from keyboard." The agent runs alone. A person reviews the result later.

The test is not easy versus hard. In our reading, an issue is ready for an agent when it is specified well enough to finish alone. It needs no judgment calls, outside access, or manual testing. A person makes that call at triage. The agent does not.

Why keep a person at this gate? Kief Morris, on martinfowler.com, splits the work into a human "why" loop and an agent "how" loop. People can be in the loop, out of it, or on it. Being on the loop means improving the system that produces the work. See [Morris's article](https://www.martinfowler.com/articles/exploring-gen-ai/humans-and-agents.html).

Anthropic makes a related point. Agents can pause for human feedback at checkpoints. When an agent works alone, small errors can pile up. So checkpoints act as a safeguard. See [Anthropic's guidance on building agents](https://www.anthropic.com/engineering/building-effective-agents).

The triage labels are meant to put this split on the issue tracker. That is design intent. The labels are documented in docs/agents/triage-labels.md. All five exist on GitHub, and a few issues already carry `needs-triage`. No automation reads them. So today the delegation decision is a convention, not a gate. We found no independent evidence that such labels improve results. Treat the design as a rationale to test.

## Why checks and tests carry more weight

An agent can say work is done when it is not. Claude Code guidance says that without something to run, "looks done" is all the agent has to go on. A test file, a build exit code, or a linter gives a real answer. As the guidance puts it, "that makes you the test suite." See [Claude Code best practices](https://code.claude.com/docs/en/best-practices).

Instructions do not force anything. The same guidance separates instructions, which a model may miss, from hooks and CI, which run every time. A rule that keeps being missed belongs in a hook.

Tests need watching too. Kent Beck describes an agent that cheats by "disabling or deleting tests." So test changes need review, not only the final result. This is one reason test-first work sits at the center of project goal 1. See [Beck's article](https://newsletter.kentbeck.com/p/augmented-coding-beyond-the-vibes).

The repository's main check is `npm run checks`. AGENTS.md calls it "the pre-commit gate." That wording overstates what exists. The script runs formatting, lint, typecheck, and tests. The formatting and lint steps fix files rather than only checking them. The script is an instruction to agents. It is not a git hook, and no CI workflow runs it. Nothing stops a commit that skips it. The source and test files it checks do not exist yet. So it probably cannot pass today. That is our inference from tool defaults. It has not been run.

Industry data points the same way. The [DORA 2025 year-in-review](https://dora.dev/insights/dora-2025-year-in-review/) says AI can raise throughput but can hurt stability when the foundation is weak. So build the checks before scaling agent output. We did not read the full DORA report.

## Why a kata, and why Diataxis

A kata is a small programming exercise. [Simon Willison's 2003 post](https://simonwillison.net/2003/Aug/27/codeKata/) describes a series of them posted by Dave Thomas, one of the authors of *The Pragmatic Programmer*. The RPG Combat kata gives its rules as incremental user stories. Each story adds constraints that push the design forward.

A kata suits a factory test for three reasons. The domain is small and well known. So, in our reading, a failure is more likely caused by the process than by the domain. In our reading, each story is meant to be roughly the size of one issue. Later stories force changes to earlier code. That tests whether agent-written code stays easy to maintain.

A kata has limits. It has no legacy code, no real stakeholders, and no production system. Results from this kata do not carry over to other projects on their own.

The documentation follows [Diataxis](https://diataxis.fr/compass/). It sorts documents into four kinds: tutorials, how-to guides, reference, and explanation. This page is an explanation. It gives context and reasons. It looks at other options. It avoids steps and command lists. The Jekyll site was chosen to match other projects, as recorded in [ADR 0001]({{ site.repository }}/blob/main/docs/adr/0001-jekyll-docs-site.md).

## Trade-offs and limits

These limits are reasons to measure and review. They are not reasons to stop.

- **Deskilling.** In a [2026 Anthropic study](https://www.anthropic.com/research/AI-assistance-coding-skills), 52 mostly junior developers learned a new library. The study found no significant speed gain from AI. The group that used AI scored 50% on a quiz about the library. The hand-coding group scored 67%. The largest gap was in debugging. The write-up cautions that the skills needed to check AI-written code may erode. If agents write all the code, people lose the practice a kata builds. Some stories could stay for human practice.
- **Perceived versus measured speed.** A [2025 randomized study](https://arxiv.org/abs/2507.09089) of experienced open-source developers, using early-2025 AI tools, found that AI slowed them down. The developers believed the tools sped them up. We read this study only through a search summary. Measure "less friction" rather than assume it.
- **Review as the bottleneck.** Kief Morris notes that agents can generate code faster than people can inspect it. He suggests improving the harness rather than fixing each output by hand. In our reading, review then limits the whole factory.
- **The metaphor.** "Factory" suggests mechanical output. Greenfield rejected that picture himself. A 2006 Microsoft blog post argues that software still needs a craftsman. See [Steve Cook's post](https://learn.microsoft.com/en-us/archive/blogs/stevecook/analogy-between-software-development-and-manufacturing). In our reading, design work does not go away. It moves into the harness and the issue briefs.
- **Third-party skills.** The [Agent Skills documentation](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) advises using skills only from trusted sources. It says to treat them like installed software. The triage roles and adapter docs follow skills written by another author. Pinning and review, already used for CI actions, could apply to skills too.
- **Upkeep.** Every rule, hook, and skill must stay accurate as the project changes. The Claude Code guidance makes the same point about hooks.
- **Historical cost.** Greenfield wrote that making a component reusable is expensive, so reuse must be systematic. In our reading, instruction files are cheap to write. Keeping them accurate is the costly part.

## Current state: what exists and what is planned

| Part | State | Note |
|---|---|---|
| AGENTS.md | Exists | Summary, scripts, and pointers. A playful opening rule shows whether an agent read it (our reading) |
| docs/agents adapter files | Exists | Tracker, labels, and domain docs |
| Triage labels | Exist on GitHub | Documented convention. No automation reads them. Category labels are not mapped |
| `npm run checks` | Instructed, not enforced | No hook and no CI run. Probably fails today (not run) |
| Project skills | None checked in; location not verified | The skills folder holds only a placeholder. Local and user-level setup was not inspected |
| Glossary (CONTEXT.md) | Absent | Upstream may have renamed it; not verified |
| CI workflows | Partial | Pin action versions and build the site. None runs tests, lint, or typecheck. A ruleset on main requires only the action-pin check |
| Kata code | Not started | No src folder and no test files |
| Story count | Unresolved | AGENTS.md says six. [user-stories.md]({{ site.repository }}/blob/main/user-stories.md) has five sections and 14 numbered rules |

## Open questions

- Does `npm run checks` pass once the first story has tests?
- Does a delegation label change outcomes? We found no independent evidence so far. The [project blog]({{ site.baseurl }}/blog/) is a place to test it.

## Further reading

- [Software Factory overview]({{ site.baseurl }}/software-factory/software-factory/): what the factory is and how this section is organized.
- [Tutorial]({{ site.baseurl }}/software-factory/tutorial/sf-tutorial/), [How-to guides]({{ site.baseurl }}/software-factory/how-to/sf-how-to/), and [Reference]({{ site.baseurl }}/software-factory/reference/sf-reference/): the other three Diataxis kinds. They are still being written.
- [Diataxis: the compass](https://diataxis.fr/compass/): how the four kinds differ.
- [AGENTS.md](https://agents.md/): the open format for agent instructions.
- [Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents): why context is a budget.
- [Humans and Agents in Software Engineering Loops](https://www.martinfowler.com/articles/exploring-gen-ai/humans-and-agents.html) by Kief Morris: the why and how loops.
- [Augmented Coding: Beyond the Vibes](https://newsletter.kentbeck.com/p/augmented-coding-beyond-the-vibes) by Kent Beck: testing and agents.
- [Best practices for Claude Code](https://code.claude.com/docs/en/best-practices): instructions versus enforcement.
