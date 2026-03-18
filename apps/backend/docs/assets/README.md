# docs/assets

Static assets for the documentation package.

```
docs/assets/
  diagrams/        ← exported SVG assets + .mmd source files
  README.md        ← this file
```

---

## Exported Diagrams

All diagrams are exported to SVG from Mermaid source. They are embedded in [`docs/KEY_DIAGRAMS.md`](../KEY_DIAGRAMS.md) alongside their Mermaid source blocks.

| File | Diagram | Source section |
|------|---------|---------------|
| `diagrams/system-context.svg` | System Context (C4) | KEY_DIAGRAMS.md §1 |
| `diagrams/module-dependency.svg` | Module Dependency Graph | KEY_DIAGRAMS.md §2 |
| `diagrams/layer-architecture.svg` | Layer Architecture | KEY_DIAGRAMS.md §3 |
| `diagrams/job-lifecycle.svg` | TranslationJob Lifecycle | KEY_DIAGRAMS.md §4 |
| `diagrams/background-processing.svg` | Background Processing Architecture | KEY_DIAGRAMS.md §5 |
| `diagrams/catalog-decision-tree.svg` | Catalog Job Decision Tree | KEY_DIAGRAMS.md §6 |
| `diagrams/subtitle-discovery.svg` | Subtitle Discovery + Provider Fallback | KEY_DIAGRAMS.md §7 |
| `diagrams/risky-areas.svg` | Risky Areas Map | KEY_DIAGRAMS.md §8 |
| `diagrams/entity-relationship.svg` | Entity Relationship Overview | KEY_DIAGRAMS.md §9 |

---

## Source of Truth

The Mermaid code blocks in `docs/KEY_DIAGRAMS.md` are the **authoritative source** for each diagram's content.

The `.mmd` files in `docs/assets/diagrams/` are the export inputs. They must be kept in sync with the code blocks in `KEY_DIAGRAMS.md`.

**When you edit a diagram in `KEY_DIAGRAMS.md`:**
1. Copy the updated Mermaid source into the corresponding `.mmd` file in `docs/assets/diagrams/`
2. Re-run the export (see below)

---

## How to Regenerate

### Requirements

Mermaid CLI (`mmdc`) must be available:

```bash
# Check if available
mmdc --version

# Install globally if not present
npm install -g @mermaid-js/mermaid-cli
```

### Regenerate all diagrams

```bash
# From repo root
pnpm docs:diagrams

# Or directly
bash docs/scripts/export-diagrams.sh
```

### Regenerate a single diagram

```bash
mmdc -i docs/assets/diagrams/<name>.mmd \
     -o docs/assets/diagrams/<name>.svg \
     --backgroundColor transparent
```

### Export flags

| Flag | Value | Why |
|------|-------|-----|
| `--backgroundColor` | `transparent` | Clean on both light and dark backgrounds |

---

## Naming Conventions

- File names use kebab-case: `job-lifecycle.svg`
- `.mmd` and `.svg` files share the same base name
- Names describe content, not diagram number: `catalog-decision-tree`, not `diagram-6`

---

## Adding a New Diagram to the Export Set

1. Add the Mermaid code block to `docs/KEY_DIAGRAMS.md` (or another doc)
2. Copy the Mermaid code to a new `.mmd` file in `docs/assets/diagrams/`
3. Run `pnpm docs:diagrams` to generate the SVG
4. Add an `![Alt text](assets/diagrams/<name>.svg)` image tag above the Mermaid code block in the doc
5. Add the new file to the table above
