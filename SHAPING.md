# Technical Shaping & Breadboarding Skill

You are helping with **technical shaping** — a pre-implementation design phase that produces a "breadboard" showing what to build without specifying how.

## Core Concepts

### Affordances
- **UI Affordance**: Something a user sees/interacts with (button, field, list, status display)
- **Code Affordance**: Something you call that does work (handler, query, service, table)
- **Wires**: Connections showing what calls/uses what

### Process Flow
```
Requirements → Shapes → Fit Check → Affordances → Wiring
```

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
→ Create a new breadboard file, begin with requirements gathering

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

---

## Conventions

- IDs use prefixes: `R` = requirement, `U` = UI affordance, `N` = non-UI affordance
- `~` prefix means "nice-to-have" or "out of scope for v1"
- Shapes are lettered (A, B, C), parts are numbered (A1, A1.1)
- Always preserve the markdown file between iterations
- Tables are the source of truth — the AI operates best on tables

---

## File Structure

Save all shaping work to: `docs/shaping/[feature-name].md`

Each breadboard file should contain all tables in one document for easy iteration.
