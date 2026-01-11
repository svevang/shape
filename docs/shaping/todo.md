# Todo App - Breadboard

## Requirements

| ID | Requirement | Priority |
|----|-------------|----------|
| **Core CRUD** | | |
| R0 | Create a new todo with text | Must |
| R1 | View list of all todos | Must |
| R2 | Mark a todo as complete/incomplete (toggle) | Must |
| R3 | Delete a todo | Must |
| R4 | Edit a todo's text | Must |
| **Filtering** | | |
| R5 | Filter view: All / Active / Completed | Must |
| R6 | Show count of remaining (active) items | Must |
| **Bulk Actions** | | |
| R7 | Clear all completed todos | Should |
| R8 | Toggle all todos complete/incomplete | Should |
| **Persistence** | | |
| R9 | Persist todos across sessions | Must |
| **UX** | | |
| R10 | Empty state when no todos exist | Should |
| ~R11 | Drag-and-drop reordering | Could |
| ~R12 | Due dates on todos | Could |

---

## Shape A: Classic TodoMVC

| Part | Mechanism |
|------|-----------|
| **A1** | **Data Model** |
| A1.1 | `todos` table/store: id, text, completed (boolean), created_at |
| A1.2 | Optional: position field for ordering |
| **A2** | **Storage Layer** |
| A2.1 | LocalStorage for browser persistence |
| A2.2 | JSON serialization of todo list |
| **A3** | **Core Operations** |
| A3.1 | `addTodo(text)` — create with generated id, completed=false |
| A3.2 | `toggleTodo(id)` — flip completed state |
| A3.3 | `deleteTodo(id)` — remove from list |
| A3.4 | `editTodo(id, text)` — update text |
| A3.5 | `toggleAll()` — set all to complete (or all to incomplete if all complete) |
| A3.6 | `clearCompleted()` — remove all where completed=true |
| **A4** | **Query/Filter** |
| A4.1 | `getAll()` — return full list |
| A4.2 | `getActive()` — filter where completed=false |
| A4.3 | `getCompleted()` — filter where completed=true |
| A4.4 | `getActiveCount()` — count of incomplete items |
| **A5** | **UI Components** |
| A5.1 | Header with text input for new todo |
| A5.2 | Todo list showing filtered items |
| A5.3 | Todo item row: checkbox, label, delete button |
| A5.4 | Double-click to edit inline |
| A5.5 | Footer with count, filter tabs, clear completed button |
| A5.6 | Toggle-all checkbox in header |

---

## Shape B: File-Based (LLM-Friendly)

| Part | Mechanism |
|------|-----------|
| **B1** | **Data Model** |
| B1.1 | Each todo is a separate file in a `.todos/` directory |
| B1.2 | Filename: `{id}.md` (UUID or timestamp-based) |
| B1.3 | Frontmatter format: `status`, `created`, `updated` |
| B1.4 | Body contains the todo text (supports multi-line/rich content) |
| **B2** | **Storage Layer** |
| B2.1 | Filesystem read/write (Node.js fs or File System Access API) |
| B2.2 | Parse frontmatter + body on read, serialize on write |
| B2.3 | Directory watcher for external changes (LLM edits) |
| **B3** | **Core Operations** |
| B3.1 | `addTodo(text)` — create new `.md` file with frontmatter |
| B3.2 | `toggleTodo(id)` — update `status` field in frontmatter |
| B3.3 | `deleteTodo(id)` — remove file from directory |
| B3.4 | `editTodo(id, text)` — update file body |
| B3.5 | `toggleAll()` — batch update all files |
| B3.6 | `clearCompleted()` — delete files where status=done |
| **B4** | **Query/Filter** |
| B4.1 | `getAll()` — read directory, parse all files |
| B4.2 | `getActive()` — filter where status=active |
| B4.3 | `getCompleted()` — filter where status=done |
| B4.4 | `getActiveCount()` — count of active status files |
| **B5** | **UI Components** |
| B5.1 | Same as A5 (UI unchanged from Shape A) |
| **B6** | **LLM Interoperability** |
| B6.1 | Plain-text files readable/writable by any tool |
| B6.2 | Markdown format allows rich todo descriptions |
| B6.3 | Watcher reloads UI when files change externally |
| B6.4 | Optional: `.todos/README.md` explains format for LLM context |

**Example file: `.todos/2024-01-15-abc123.md`**
```markdown
---
status: active
created: 2024-01-15T10:30:00Z
updated: 2024-01-15T10:30:00Z
---
Buy groceries for the week
```

---

## Fit Check

| ID | Requirement | Shape A | Shape B |
|----|-------------|---------|---------|
| R0 | Create a new todo with text | ✅ A3.1, A5.1 | ✅ B3.1, B5.1 |
| R1 | View list of all todos | ✅ A4.1, A5.2 | ✅ B4.1, B5.1 |
| R2 | Mark a todo as complete/incomplete | ✅ A3.2, A5.3 | ✅ B3.2, B5.1 |
| R3 | Delete a todo | ✅ A3.3, A5.3 | ✅ B3.3, B5.1 |
| R4 | Edit a todo's text | ✅ A3.4, A5.4 | ✅ B3.4, B5.1 |
| R5 | Filter view: All / Active / Completed | ✅ A4.1-A4.3, A5.5 | ✅ B4.1-B4.3, B5.1 |
| R6 | Show count of remaining items | ✅ A4.4, A5.5 | ✅ B4.4, B5.1 |
| R7 | Clear all completed todos | ✅ A3.6, A5.5 | ✅ B3.6, B5.1 |
| R8 | Toggle all complete/incomplete | ✅ A3.5, A5.6 | ✅ B3.5, B5.1 |
| R9 | Persist todos across sessions | ✅ A2.1, A2.2 | ✅ B2.1, B2.2 |
| R10 | Empty state when no todos | ✅ A5.2 (conditional render) | ✅ B5.1 |
| ~R11 | Drag-and-drop reordering | ⚠️ A1.2 supports, UI not specified | ⚠️ Would need `position` in frontmatter |
| ~R12 | Due dates | ❌ Not addressed | ✅ Easy to add `due` to frontmatter |

### Shape Comparison

| Aspect | Shape A (LocalStorage) | Shape B (File-Based) |
|--------|------------------------|----------------------|
| **Setup complexity** | None (browser built-in) | Needs fs access or backend |
| **LLM access** | ❌ Opaque to external tools | ✅ Direct file read/write |
| **Multi-line todos** | Awkward | ✅ Native (markdown body) |
| **External sync** | ❌ Browser-only | ✅ Git, Dropbox, etc. |
| **Portability** | Browser-locked | ✅ Any tool can read |
| **Live reload** | N/A | ✅ Watcher detects changes |
| **Performance** | Fast (in-memory) | Slower (file I/O) |

---

## Next Steps

Ready for:
- **Populate UI affordances** — extract U# table
- **Populate code affordances** — extract N# table
- **Wire it up** — connect affordances with flow diagram
