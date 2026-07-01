#!/usr/bin/env bash
set -euo pipefail

if [[ -x "${HOME}/.local/bin/uvx" ]]; then
  UVX="${HOME}/.local/bin/uvx"
elif command -v uvx >/dev/null 2>&1; then
  UVX="$(command -v uvx)"
else
  echo "uvx not found. Install uv: curl -LsSf https://astral.sh/uv/install.sh | sh" >&2
  exit 1
fi

export UV_PYTHON_PREFERENCE="${UV_PYTHON_PREFERENCE:-only-managed}"
export BLENDER_HOST="${BLENDER_HOST:-localhost}"
export BLENDER_PORT="${BLENDER_PORT:-9876}"

exec "$UVX" --python 3.11 blender-mcp
