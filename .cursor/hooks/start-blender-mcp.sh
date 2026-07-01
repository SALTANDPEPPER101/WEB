#!/usr/bin/env bash
# Auto-start Blender MCP when a Cursor agent session begins.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
"$ROOT_DIR/scripts/start-blender-mcp.sh" >/dev/null 2>&1 || true

cat <<'EOF'
{
  "additional_context": "Blender MCP is configured for this project. The Blender addon should be listening on localhost:9876. Use Blender MCP tools when available."
}
EOF
