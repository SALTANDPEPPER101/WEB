"""Enable Blender MCP addon and keep Blender running for MCP connections."""
import addon_utils
import bpy
import time

addon_utils.enable("blender_mcp", default_set=True, persistent=True)

server = getattr(bpy.types, "blendermcp_server", None)
if server and server.running:
    print(f"BlenderMCP server listening on port {server.port}", flush=True)
else:
    print("BlenderMCP server failed to start — check addon output", flush=True)

# Keep Blender alive so the MCP socket server stays up.
while True:
    time.sleep(1)
