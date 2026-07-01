"""Install and enable the Blender MCP addon (run with: blender --background --python ...)."""
import bpy

ADDON_PATH = "/workspace/blender-mcp/addon.py"
MODULE_NAME = "addon"


def main() -> None:
    bpy.ops.preferences.addon_install(filepath=ADDON_PATH, overwrite=True)
    bpy.ops.preferences.addon_enable(module=MODULE_NAME)
    bpy.ops.wm.save_userpref()
    print("Blender MCP addon installed and enabled")


if __name__ == "__main__":
    main()
