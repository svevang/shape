# Breadboard

An AI agent skill for technical shaping: Designing features before
implementation using structured "breadboard" documents.

## Startup Context

This skill uses two files that should be loaded in the agent's startup context:

- `SHAPING.md`  Core concepts, table formats, and conventions
- `BREADBOARD_TEMPLATE.md`  Starter template for new breadboards

## User Interaction

The shaping workflow is driven by natural language commands:

| Command | What it does |
|---------|--------------|
| `Start shaping [feature]` | Create a new breadboard file, begin requirements gathering |
| `Add requirement: [description]` | Add a row to the requirements table |
| `Propose a shape` | Generate a solution approach that addresses requirements |
| `Fit check` | Create/update matrix showing how shapes satisfy requirements |
| `Populate UI affordances` | Extract user-facing elements from the chosen shape |
| `Populate code affordances` | Extract backend/code elements from the shape |
| `Wire it up` | Connect affordances and generate a wiring diagram |
| `Show breadboard` | Display current state of all tables |

## Output

Breadboards are saved to `docs/shaping/[feature-name].md` and contain:

1. **Requirements**  What must be accomplished (with IDs and priorities)
2. **Shapes**  Solution approaches with named mechanisms
3. **Fit Check**  Matrix mapping requirements to shape mechanisms
4. **Affordances**  UI and code elements extracted from the shape
5. **Wiring Diagram**  ASCII diagram showing how affordances connect
