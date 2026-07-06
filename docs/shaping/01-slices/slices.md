---
status: ready
selected_shape: A
updated: 2026-07-06
---

# Shape: Slices

## Problem Statement

The skill's process ends at wiring. A finished breadboard says what to build
but not how to ship it incrementally. Slices extend the breadboard by
partitioning affordances into shippable increments, so the person implementing
knows what to build first and when something is demoable.

---

## Requirements

| ID  | Requirement | Priority |
|-----|-------------|----------|
| R0  | Partition a shaped feature into shippable increments (slices) | Must |
| R1  | Each slice lists the affordances it builds and the requirements it proves | Must |
| R2  | A slice breaks down into sub-slices — smaller changes within it | Must |
| R3  | Slices express dependencies: sequential by default, parallel/independent when possible | Must |
| ~R4 | Verify every must-have affordance is claimed by some slice | Could |

---

## Shape A: Slices Table

| Part | Mechanism |
|------|-----------|
| A1   | **Slices table** |
| A1.1 | New section in the breadboard between Non-UI Affordances and Wiring Diagram |
| A1.2 | Columns: `#`, `Slice`, `Builds` (U#/N# refs), `Proves` (R# refs), `Depends On` (S# refs) |
| A1.3 | Slice rows (`S1`, `S2`) are shippable increments, named in bold like shape subsystems |
| A1.4 | Sub-slice rows (`S1.1`, `S1.2`) are some changes within a slice |
| A1.5 | `Builds`/`Proves` live on slice and sub-slice rows; either cell may be left blank |
| A2   | **Dependencies** |
| A2.1 | Slices are sequential by default: each implicitly depends on the previous slice |
| A2.2 | `Depends On` overrides the default — explicit S# refs, or `–` for independent/parallel |
| A3   | **Process flow** |
| A3.1 | Flow becomes: Requirements → Shapes → Fit Check → Affordances → Slices → Wiring |
| A4   | **Workflow commands** |
| A4.1 | "Slice it up" → generate the slices table from the affordance tables |
| A4.2 | "Add slice: [description]" → append with next S# |
| ~A4.3 | "Slice check" → report must-have affordances not claimed by any slice |
| A5   | **Skill document updates** |
| A5.1 | Add Slices section to the breadboard template and `S` to the ID conventions |
| A5.2 | "Show breadboard" and "Resume shaping" include slice status |

---

## Fit Check

| ID | Requirement | Current | A |
|----|-------------|---------|---|
| R0 | Partition a shaped feature into shippable increments (slices) | ❌ | ✅ |
| R1 | Each slice lists the affordances it builds and the requirements it proves | ❌ | ✅ |
| R2 | A slice breaks down into sub-slices — smaller changes within it | ❌ | ✅ |
| R3 | Slices express dependencies: sequential by default, parallel/independent when possible | ❌ | ✅ |
| ~R4 | Verify every must-have affordance is claimed by some slice | ❌ | ✅ |

Legend: ✅ = satisfied, ❌ = not satisfied, – = not applicable

---

## UI Affordances

| #  | Place | Affordance | Description | Wires Out |
|----|-------|------------|-------------|-----------|
| U1 | Breadboard document (new section) | Slices table | Sits between Non-UI Affordances and Wiring Diagram; columns `#`, `Slice`, `Builds`, `Proves`, `Depends On` | U2 |
| U2 | Slices table | Slice row (`S#`) | Bold-named shippable increment | U3, U4 |
| U3 | Slices table | Sub-slice row (`S#.#`) | A change within a slice; carries `Builds`/`Proves` when present | |
| U4 | Slices table | `Depends On` cell | Overrides the sequential default: explicit S# refs, or `–` for independent/parallel | |

---

## Non-UI Affordances

| #  | Component | Affordance | Description | Wires Out |
|----|-----------|------------|-------------|-----------|
| N1 | Workflow commands | "Slice it up" | Generates the slices table from the affordance tables | U1 |
| N2 | Workflow commands | "Add slice: [description]" | Appends a slice with the next S# | U2 |
| ~N3 | Workflow commands | "Slice check" | Reports must-have affordances not claimed by any slice | U1 |
| N4 | Breadboard template | Slices section | Empty slices table in the new-breadboard template | U1 |
| N5 | Conventions | `S` ID prefix | Documents slice IDs and the sequential-default dependency rule | U2, U4 |
| N6 | Workflow commands | "Show breadboard" / "Resume shaping" | Extended to include slice status | U1 |

---

## Wiring Diagram

```
┌─ TRIGGER: "Slice it up" ───────────────────────────────┐
│                                                         │
│  N1 slice it up (reads affordance tables)               │
│      └─► U1 slices table                                │
│              └─► U2 slice rows ──► U3 sub-slice rows    │
│                       └─► U4 depends-on cells           │
└─────────────────────────────────────────────────────────┘

┌─ TRIGGER: "Add slice: [description]" ──────────────────┐
│                                                         │
│  N2 add slice ──► U2 slice row (next S#)                │
└─────────────────────────────────────────────────────────┘

┌─ TRIGGER: "Slice check" (~) ───────────────────────────┐
│                                                         │
│  N3 slice check (reads U1 + affordance tables)          │
│      └─► report of unclaimed must-have affordances      │
└─────────────────────────────────────────────────────────┘

┌─ PLACE: New breadboard ────────────────────────────────┐
│                                                         │
│  N4 template ──► U1 empty slices table                  │
│  N5 conventions ──► U2/U4 ID + dependency rules         │
└─────────────────────────────────────────────────────────┘

┌─ TRIGGER: "Show breadboard" / "Resume shaping" ────────┐
│                                                         │
│  N6 summary (reads U1) ──► slice status                 │
└─────────────────────────────────────────────────────────┘
```

---

## Open Questions

- [ ]
