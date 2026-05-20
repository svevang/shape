# "Shape" Agent Skill

An AI agent skill for technical shaping. Helps gather and specify:

- Requirements
- Shapes
- Affordances

The shapes are checked against the requirements to ensure there is a fit
between the shape and the requirements. The affordances are wired together in a
breadboard to guide implementation. 

## Example: TODO app

### Requirements

| ID | Requirement | Priority |
|----|-------------|----------|
| R0 | Create a new todo with text | Must |
| R1 | View list of all todos | Must |
| R2 | Mark a todo as complete/incomplete | Must |
| R3 | Delete a todo | Must |
| R4 | Filter view: All / Active / Completed | Must |
| R5 | Persist todos across sessions | Must |
| R6 | Clear all completed todos | Should |

### Shape A: Classic TodoMVC

| Part | Mechanism |
|------|-----------|
| **A1** | **Data Model** |
| A1.1 | `todos` store: id, text, completed, created_at |
| **A2** | **Storage** |
| A2.1 | LocalStorage with JSON serialization |
| **A3** | **Operations** |
| A3.1 | `addTodo(text)`, `toggleTodo(id)`, `deleteTodo(id)` |
| A3.2 | `clearCompleted()` — remove all where completed=true |
| **A4** | **UI** |
| A4.1 | Header with text input, todo list, footer with filters |

### Fit Check

| ID | Requirement | A |
|----|-------------|---|
| R0 | Create todo | ✅ A3.1, A4.1 |
| R1 | View all | ✅ A4.1 |
| R2 | Toggle complete | ✅ A3.1 |
| R3 | Delete | ✅ A3.1 |
| R4 | Filter views | ✅ A4.1 |
| R5 | Persist | ✅ A2.1 |
| R6 | Clear completed | ✅ A3.2 |

### UI Affordances

| # | Place | Affordance | Description | Wires Out |
|---|-------|------------|-------------|-----------|
| U1 | Header | Text input | Enter new todo text | N1 |
| U2 | Todo list | Checkbox | Toggle complete/incomplete | N2 |
| U3 | Todo list | Delete button | Remove a todo | N3 |
| U4 | Footer | Filter tabs | Switch All/Active/Completed | N4 |
| U5 | Footer | Clear completed button | Remove done todos | N5 |

### Non-UI Affordances

| # | Component | Affordance | Description | Wires Out |
|---|-----------|------------|-------------|-----------|
| N1 | TodoService | `addTodo(text)` | Create todo, save to store | N6 |
| N2 | TodoService | `toggleTodo(id)` | Flip completed state | N6 |
| N3 | TodoService | `deleteTodo(id)` | Remove from store | N6 |
| N4 | TodoService | `filterTodos(mode)` | Return filtered list | |
| N5 | TodoService | `clearCompleted()` | Delete all completed | N6 |
| N6 | Storage | `localStorage` | JSON persist/load | |

### Wiring Diagram

```
┌─ PLACE: Todo App ──────────────────────────────┐
│                                                 │
│  U1 TextInput                                   │
│      └─► N1 addTodo() ──► N6 localStorage       │
│                                                 │
│  U2 Checkbox                                    │
│      └─► N2 toggleTodo() ──► N6 localStorage    │
│                                                 │
│  U3 DeleteButton                                │
│      └─► N3 deleteTodo() ──► N6 localStorage    │
│                                                 │
│  U4 FilterTabs                                  │
│      └─► N4 filterTodos()                       │
│                                                 │
│  U5 ClearCompleted                              │
│      └─► N5 clearCompleted() ──► N6 localStorage│
└─────────────────────────────────────────────────┘
```

## Install

```bash
git clone git@github.com:svevang/shape.git
cd shape
./install.sh
```

This installs the skill globally for **Claude Code**, **Codex**, and **Pi Agent**.

## Usage

In Claude Code:
```
/shape
```

In Codex:
```
$shape
```

In Pi:
```
/skill:shape
```

Then converse naturally using shaping commands:

| Command | What it does |
|---------|--------------|
| `Start shaping [feature]` | Create a new breadboard file or shaping directory, begin requirements gathering |
| `Add requirement: [description]` | Add a row to the requirements table |
| `Propose a shape` | Generate a solution approach that addresses requirements |
| `Fit check` | Create/update matrix showing how shapes satisfy requirements |
| `Populate UI affordances` | Extract user-facing elements from the chosen shape |
| `Populate code affordances` | Extract backend/code elements from the shape |
| `Wire it up` | Connect affordances and generate a wiring diagram |
| `Show breadboard` | Display current state of all tables |
| `Where did we leave off?` | Summarize selected shape, fit check status, what's unsolved |

## Output

Breadboards can be saved as either:

```text
docs/shaping/NN-[feature-name].md
docs/shaping/NN-[feature-name]/[feature-name].md
```

Use the directory form when a shape has supporting material. The supporting
file layout inside the directory is flexible.

```text
docs/shaping/02-import-flow/
  import-flow.md
  resources/
    product-brief.pdf
    current-flow.png
  notes/
    research.md
```

Breadboards contain:

1. **Requirements** - What must be accomplished (with IDs and priorities)
2. **Shapes** - Solution approaches with named mechanisms
3. **Fit Check** - Matrix mapping requirements to shape mechanisms
4. **Affordances** - UI and code elements extracted from the shape
5. **Wiring Diagram** - ASCII diagram showing how affordances connect
