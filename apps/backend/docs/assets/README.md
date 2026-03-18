# docs/assets

This directory holds exported diagram assets (SVG, PNG) for use in wikis, onboarding slides, and external documentation.

## Generating assets

All diagrams in this project are written in Mermaid and live in the `.md` files under `docs/`.

To export a diagram to SVG or PNG, use the [Mermaid CLI](https://github.com/mermaid-js/mermaid-cli):

```bash
# Install globally
npm install -g @mermaid-js/mermaid-cli

# Export a diagram to SVG
# 1. Copy the mermaid block to a .mmd file
# 2. Run:
mmdc -i diagram.mmd -o docs/assets/diagram.svg
```

Or use the [Mermaid Live Editor](https://mermaid.live) to paste and download.

## Priority export list

These diagrams from [KEY_DIAGRAMS.md](../KEY_DIAGRAMS.md) are the best candidates for export:

| Diagram | Source section | Export priority |
|---------|---------------|-----------------|
| System Context (C4) | KEY_DIAGRAMS.md § 1 | High — good for external audiences and READMEs |
| TranslationJob State Machine | KEY_DIAGRAMS.md § 4 | High — reference in job-related PRs |
| Module Dependency Graph | KEY_DIAGRAMS.md § 2 | High — onboarding materials |
| Background Processing Architecture | KEY_DIAGRAMS.md § 5 | Medium — ops/infra understanding |
| Catalog Job Decision Tree | KEY_DIAGRAMS.md § 6 | Medium — complex; SVG makes it zoomable |
| Risky Areas Map | KEY_DIAGRAMS.md § 8 | Medium — contributor onboarding |
