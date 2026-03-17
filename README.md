# Breadboard

An AI agent skill for technical shaping: designing features before
implementation using structured "breadboard" documents.

## Install

```bash
git clone <this-repo>
cd breadboard
./install.sh
```

This installs the skill globally for both **Claude Code** and **Pi Agent**.

## Usage

In Claude Code:
```
/shape
```

In Pi:
```
/skill:shape
```

Then converse naturally using shaping commands:

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
| `Where did we leave off?` | Summarize selected shape, fit check status, what's unsolved |

## Output

Breadboards are saved to `docs/shaping/[feature-name].md` and contain:

1. **Requirements** - What must be accomplished (with IDs and priorities)
2. **Shapes** - Solution approaches with named mechanisms
3. **Fit Check** - Matrix mapping requirements to shape mechanisms
4. **Affordances** - UI and code elements extracted from the shape
5. **Wiring Diagram** - ASCII diagram showing how affordances connect
