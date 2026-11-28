---
name: bdd-formulation
description: Use when writing or reviewing Gherkin scenarios, especially after discovering examples or edge cases that reveal a business rule
---

# BDD Formulation

Formulation is the craft of writing Gherkin that serves as
living documentation. Good scenarios are concrete examples
of business rules, not test scripts.

## Core Habit

When examples reveal a rule, make the rule visible in the
feature file: group related scenarios under a rule heading that
states the rule they illustrate.

Use Gherkin `Rule:` keywords to group scenarios by business/domain rule. This repo uses Cucumber.js, which supports `Rule:`.

```gherkin
Rule: Damage cannot reduce Health below 0

  Scenario: A heavy blow leaves a wounded character dead at 0 Health
    Given Aria has 300 Health
    When Borin deals 500 damage to Aria
    Then Aria has 0 Health
    And Aria is dead
```

## BRIEF Check

From Seb Rose, scenarios should be:

- **B**usiness language: terms stakeholders understand.
- **R**eal data: vivid, concrete examples.
- **I**ntention revealing: say what matters, not how the UI works.
- **E**ssential: every line serves the rule.
- **F**ocused: one rule per scenario, short enough to read.

## Guidelines

- Use `Rule:` headings for business/domain rules, not implementation mechanisms.
- Keep scenario names as concrete examples of the rule, not restatements of it.
- If a scenario discovers a new rule, add or split out a new commented rule-heading section.
- If a scenario appears to illustrate multiple rules, split it.
- Prefer several small commented rule-heading groups over one long pile of loosely related scenarios.
- Carry one consistent narrative through a feature where possible.
- Put cross-cutting assertions, such as output or logging, on existing scenarios rather than in separate rules.

## Review Questions

- What rule does this scenario prove?
- Does the Example name add information beyond the Rule?
- Is every line essential?
- Is the data concrete and business-readable?
- Would a feature with no `Rule:` sections be clearer if its rules were extracted?
