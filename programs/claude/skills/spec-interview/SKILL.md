---
name: spec-interview
description: Interviews the user then writes a spec file. Use when the user wants to capture requirements for something they want to build.
---

Use AskUserQuestion to interview the user one question at a time about a feature they want to build. Requirements must be concrete and verifiable. Keep interviewing until a shared understanding is reached and no ambiguity would block implementation.

If a question can be answered by exploring the codebase, explore the codebase instead.

Then write a spec to `docs/spec/NNN-short-name.md` (create dir if needed, increment from highest existing number):

```
# [Title]

## Overview

## Requirements

## Constraints

## Non-goals

## Verification
[Concrete runnable commands]

## Open questions
```
