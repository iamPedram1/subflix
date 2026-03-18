#!/usr/bin/env bash
# Export Mermaid diagrams to SVG.
#
# Source .mmd files: docs/assets/diagrams/*.mmd
# Output SVG files: docs/assets/diagrams/*.svg
#
# Requirements: mmdc (Mermaid CLI) must be on PATH.
#   Install globally:  npm install -g @mermaid-js/mermaid-cli
#   Or use locally:    pnpm add -D @mermaid-js/mermaid-cli
#
# Run from the repo root:
#   bash docs/scripts/export-diagrams.sh
#   pnpm docs:diagrams

set -uo pipefail

DIAGRAMS_DIR="docs/assets/diagrams"
MMDC_FLAGS="--backgroundColor transparent"

if ! command -v mmdc &>/dev/null; then
  echo "Error: mmdc not found. Install with: npm install -g @mermaid-js/mermaid-cli"
  exit 1
fi

echo "Mermaid CLI: $(mmdc --version)"
echo "Exporting diagrams from $DIAGRAMS_DIR/"
echo ""

SUCCESS=0
FAILED=0

for mmd_file in "$DIAGRAMS_DIR"/*.mmd; do
  base=$(basename "$mmd_file" .mmd)
  svg_file="$DIAGRAMS_DIR/$base.svg"

  printf "  %-40s" "$base.mmd"
  if mmdc -i "$mmd_file" -o "$svg_file" $MMDC_FLAGS 2>/dev/null; then
    size=$(wc -c < "$svg_file" 2>/dev/null || echo "?")
    echo "OK  (${size} bytes)"
    SUCCESS=$((SUCCESS + 1))
  else
    echo "FAILED"
    FAILED=$((FAILED + 1))
  fi
done

echo ""
echo "Done: $SUCCESS exported, $FAILED failed."
if [ "$FAILED" -gt 0 ]; then
  exit 1
fi
