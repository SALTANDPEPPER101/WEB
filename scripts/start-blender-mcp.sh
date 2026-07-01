#!/usr/bin/env bash
set -euo pipefail

BLENDER_BIN="${BLENDER_BIN:-blender}"
ADDON_INSTALL_SCRIPT="/workspace/scripts/blender-mcp-install.py"

echo "Installing Blender MCP addon..."
xvfb-run -a "$BLENDER_BIN" --background --python "$ADDON_INSTALL_SCRIPT"

echo "Starting Blender with MCP server (virtual display via xvfb)..."
exec xvfb-run -a "$BLENDER_BIN"
