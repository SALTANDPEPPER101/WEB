#!/usr/bin/env bash
# Start Blender with the MCP addon on localhost:9876 (requires xvfb on headless systems).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
ADDON_DIR="${HOME}/.config/blender/4.0/scripts/addons/blender_mcp"
LOG_FILE="/tmp/blender-mcp.log"

mkdir -p "$ADDON_DIR"
cp "$ROOT_DIR/blender-mcp/addon.py" "$ADDON_DIR/__init__.py"

if pgrep -f "blender --python $ROOT_DIR/blender-mcp/start_blender_mcp.py" >/dev/null 2>&1; then
  echo "Blender MCP is already running (see $LOG_FILE)"
  exit 0
fi

echo "Starting Blender MCP server..."
if command -v xvfb-run >/dev/null 2>&1; then
  nohup xvfb-run -a blender --python "$ROOT_DIR/blender-mcp/start_blender_mcp.py" >"$LOG_FILE" 2>&1 &
else
  nohup blender --python "$ROOT_DIR/blender-mcp/start_blender_mcp.py" >"$LOG_FILE" 2>&1 &
fi

for _ in $(seq 1 30); do
  if python3 - <<'PY' 2>/dev/null; then
import socket
s = socket.socket()
s.settimeout(0.5)
try:
    s.connect(("127.0.0.1", 9876))
    raise SystemExit(0)
except OSError:
    raise SystemExit(1)
finally:
    s.close()
PY
    echo "Blender MCP listening on localhost:9876"
    exit 0
  fi
  sleep 1
done

echo "Timed out waiting for Blender MCP. Check $LOG_FILE"
exit 1
