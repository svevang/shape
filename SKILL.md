---
name: shape
description: Technical shaping and breadboarding skill. Use when the user wants to design a feature before implementation using structured breadboard documents. Triggered by commands like "start shaping", "propose a shape", "fit check", "wire it up".
---

# Technical Shaping & Breadboarding Skill

You are helping with **technical shaping** — a pre-implementation design phase
loosely based on the basecamp/37-signals "shape up" methodology. You are
producing a design document based on a schema.

Whenever you are working specifically on shaping or making changes to the
design document, you are in an iterative, interactive flow. Ask questions,
show the user, and let them drive the process.

Before applying an edit, show the user the changes and get their assent —
unless the user has told you to apply edits without confirmation.

When you first launch the skill, look in the shaping directory `docs/shaping`
and list the existing shaping files.

## Core Concepts

### Definitions
- **Requirement**: The starting point in design — a handful of line items describing the problem space and what the solution must accomplish
- **Shape**: A rough solution concept. Bounded enough to evaluate, but not so detailed that it prescribes implementation. The shape is where design decisions get made.
- **Fit Check**: A matrix that maps shapes to requirements, verifying the shape covers what it needs to
- **UI Affordance**: Something a user sees/interacts with (button, field, list, status display)
- **Code Affordance**: Something you call that does work (handler, query, service, table)
- **Breadboard Wires**: Connections showing what calls/uses what

### Process Flow

```
Requirements → Shapes → Fit Check → Affordances → Wiring
```

Your role is **facilitator, not author**. The user leads; you keep the process
moving. For each step:

1. **Orient** — remind the user which section is next and what it captures
2. **Ask** — pose 1-2 focused questions to draw out their thinking (don't shotgun a list)
3. **Listen** — let them answer; reflect back what you heard to confirm understanding
4. **Offer** — only draft content when the user asks, or when they're clearly stuck

Never auto-fill a section unprompted. If the user gives a vague answer, ask a
follow-up rather than guessing. When you do draft, present it as a proposal
("here's a starting point — edit freely") not a finished artifact.

---

## Table Formats

### 1. Requirements Table
Capture what the solution must accomplish. Use IDs for cross-referencing.

```markdown
## Requirements

| ID  | Requirement | Priority |
|-----|-------------|----------|
| R0  | [Core goal] | Must |
| R1  | [Specific behavior] | Must |
| R2  | [Constraint] | Should |
| ~R3 | [Nice-to-have, marked with ~] | Could |
```

### 2. Shapes Table
A "shape" is a solution approach. Define mechanisms that make it work.

```markdown
## Shape A: [Name]

| Part | Mechanism |
|------|-----------|
| A1   | **[Subsystem name]** |
| A1.1 | [Specific mechanism detail] |
| A1.2 | [Another detail] |
| A2   | **[Next subsystem]** |
| A2.1 | [Detail] |
```

Use `~` prefix for parts that are optional/nice-to-have.

**Notes on writing mechanisms:**
- Reference affordance IDs (N#, U#) when describing data flow
- Include removal of existing functionality when replacing/simplifying
- Can reference key files when location matters

### 3. Fit Check Table
Matrix showing how each shape satisfies requirements.

```markdown
## Fit Check

| ID | Requirement | Current | A | B |
|----|-------------|---------|---|---|
| R0 | [requirement] | ❌ | ✅ | ✅ |
| R1 | [requirement] | ❌ | ✅ | ✅ |
| R2 | [requirement] | – | ✅ | ✅ |
```

Legend: ✅ = satisfied, ❌ = not satisfied, – = not applicable

### 4. UI Affordances Table

```markdown
## UI Affordances

| #  | Place | Affordance | Description | Wires Out |
|----|-------|------------|-------------|-----------|
| U1 | [Screen/page (new/existing)] | [element name] | [what it does] | [N# refs] |
| U2 | [Screen/page] | [element] | [description] | |
```

### 5. Non-UI (Code) Affordances Table

```markdown
## Non-UI Affordances

| #  | Component | Affordance | Description | Wires Out |
|----|-----------|------------|-------------|-----------|
| N1 | [Table/Service/Handler] | [fields or method signature] | [what it does] | |
| N2 | [Component] | [affordance] | [description] | [N#, U#] |
```

### 6. Wiring Diagram
ASCII diagram showing flow between affordances, grouped by place/trigger.

```markdown
## Wiring Diagram

┌─ PLACE: [Screen name] ─────────────────────────┐
│                                                 │
│  N# functionName()                              │
│      └─► U# element ──► N# otherFunction()      │
│                              └─► N# storage     │
└─────────────────────────────────────────────────┘

┌─ TRIGGER: [Event name] ────────────────────────┐
│                                                 │
│  N# onEvent()                                   │
│      └─► N# service()                           │
│              └─► N# storage                     │
└─────────────────────────────────────────────────┘
```

---

## Workflow Commands

When the user says:

**"Start shaping [feature]"**
→ Create a new breadboard file or shaping directory, begin with requirements gathering

**"Add requirement: [description]"**
→ Add to requirements table with next available ID

**"Propose a shape"**
→ Generate a shape that addresses the requirements

**"Fit check"**
→ Generate/update the fit check matrix

**"Populate UI affordances"**
→ Extract UI affordances from the chosen shape

**"Populate code affordances"**
→ Extract code/non-UI affordances from the chosen shape

**"Wire it up"**
→ Add Wires Out column values and generate wiring diagram

**"Show breadboard"**
→ Display the current state of all tables

**"Where did we leave off?" / "Resume shaping"**
→ Summarize: selected shape, fit check status, what's unsolved

---

## Conventions

- IDs use prefixes: `R` = requirement, `U` = UI affordance, `N` = non-UI affordance
- `~` prefix means "nice-to-have" or "out of scope for v1"
- Shapes are lettered (A, B, C), parts are numbered (A1, A1.1)
- Always preserve the markdown file between iterations
- Tables are the source of truth — the AI operates best on tables

### Conciseness

Please make sure to remove all unnecessary language and verbiage. You must keep
the language as simple and spare as possible. If a single sentence will
suffice, then only use a single sentence. Don't aggregate edits, instead you
must resolve.

We must keep requirements as clear and plain as possible. It should reflect the
user story and motivation of the end user. If the goal is to build tool, then
the requirements reflect the user that holds it. If the goal is a website, it's
the user that browses it.

If there is a requirement with large and complex descriptions, this could
indicate if there are shaping level details that could be extracted out to the
shaping section. Carefully review to see it there are shaping details that can
be extracted.

Also, consider carefully if affordance details have leaked into the shape. We
must make sure that the shape is as pure as possible and does not reflect the
underlying architecture and implementation details.

### Reader-First Determinations

Write determinations for the hypothetical reader who opens the shaping document
and is reading it freshly — not as a transcript of every turn in the shaping
conversation. The reader should not see the archaeology of the document
construction, rather they should see a polished, self-contained, product that
stands on its own, irrespective of history.

Ensure that you do not make edits as a reaction to what was previously written.
You must create the structure of the shaping document so it is forward looking,
not backward or reactionary to a previous decision -- only express the forward
and positive elements of the shaping document. You must create a document with
a clear presentation, not a history or record of decisions.

Prefer positive statements of the current shape. Use negative determinations
sparingly, and only when the rejected path is a real implementation hazard a
future reader might reasonably choose. Do not use phrasing that mainly explains
a past conversational detour, such as "do not rename X" or "this intentionally
does not use Y", unless that contrast is absolutely needed to prevent a likely
mistake.

Decision history belongs in eliminated shapes, open questions, or short notes
when it helps implementation judgment. The main shape should read as the
present design, not as a precise history of how each decision was reached.

---

## File Structure

Shaping work can use either a single-file form or a directory form.

### Single-file form

Use this when the shape has no supporting files:

`docs/shaping/NN-[feature-name].md`

Example: `docs/shaping/01-my-feature.md`

### Directory form

Use this when the shape has supporting material such as PDFs, screenshots,
sample data, logs, diagrams, or research notes:

`docs/shaping/NN-[feature-name]/[feature-name].md`

Example:

```text
docs/shaping/02-import-flow/
  AGENTS.md
  import-flow.md
  resources/
    product-brief.pdf
    current-flow.png
  notes/
    research.md
```

When an entry under `docs/shaping` is a directory, treat the matching markdown
file inside it as the primary breadboard. The repeated feature name is
intentional so the document keeps its identity if copied or emailed by itself.

The supporting file layout inside the directory is intentionally flexible; use
whatever grouping makes the material easiest to understand for that shape. The
example above is only illustrative.

Supporting files are part of the shape context by proximity. Do not require a
manifest, index, or supporting-material table. When working on a directory-form
shape, inspect the directory contents first, then read only the supporting
files that appear relevant to the current shaping question. Reference
supporting files naturally in prose when they inform a requirement, shape,
tradeoff, affordance, or open question.

If there is an AGENTS.md file in the directory it will provide you with
additional shape-specific context, workflows, and details. Please read this
file in its entirety in the context of this skill and the shape it is nested
within. The nested AGENTS.md file is an extension for this skill that only
applies to the shape being worked on.

### Converting to directory form

When converting an existing single-file shape to directory form, move:

`docs/shaping/NN-[feature-name].md`

to:

`docs/shaping/NN-[feature-name]/[feature-name].md`

After moving the file, update relative links inside the markdown because the
document is now one directory deeper. For example, a link that used to point to
`../assets/example.png` from `docs/shaping/NN-[feature-name].md` may need to
point to `../../assets/example.png` from
`docs/shaping/NN-[feature-name]/[feature-name].md`. Links to supporting files
placed inside the new shape directory should be rewritten relative to the new
markdown file location.

Each breadboard should contain all core tables in one document for easy
iteration.

---

## Breadboard Template

When starting a new breadboard, use this markdown template:


```
# Shape: [Feature Name]

> Status: Draft | Shaping | Ready
> Last updated: [date]

## Problem Statement

[What problem are we solving? Who has it? Why does it matter?]

---

## Requirements

| ID  | Requirement | Priority |
|-----|-------------|----------|
| R0  | | Must |
| R1  | | Must |
| R2  | | Should |

---

## Shape A: [Name]

| Part | Mechanism |
|------|-----------|
| A1   | **[Subsystem]** |
| A1.1 | |

---

## Fit Check

| ID | Requirement | Status | Current | A |
|----|-------------|--------|---------|---|
| R0 | | Core goal | | |

Status values: `Core goal`, `Must-have`, `Should`, `Out`, `Undecided`

---

## UI Affordances

| #  | Place | Affordance | Description | Wires Out |
|----|-------|------------|-------------|-----------|
| U1 | | | | |

---

## Non-UI Affordances

| #  | Component | Affordance | Description | Wires Out |
|----|-----------|------------|-------------|-----------|
| N1 | | | | |

---

## Wiring Diagram

```
[Generated after affordances are populated]
```

---

## Eliminated Shapes

[Record eliminated shapes when the contrast helps future implementation judgment. Keep this concise; the main shape should read as the present design, not a precise history of every decision.]

| Shape | Name | Why Eliminated |
|-------|------|----------------|
| A | | |

---

## What's Unsolved

[Open design questions that block progress. Updated each session for resumption.]

-

---

## Open Questions

- [ ]
```
