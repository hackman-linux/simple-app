# Generated code do not commit.
file(TO_CMAKE_PATH "/home/hackman/development/flutter" FLUTTER_ROOT)
file(TO_CMAKE_PATH "/home/hackman/development2/my_app" PROJECT_DIR)

set(FLUTTER_VERSION "1.0.0+1" PARENT_SCOPE)
set(FLUTTER_VERSION_MAJOR 1 PARENT_SCOPE)
set(FLUTTER_VERSION_MINOR 0 PARENT_SCOPE)
set(FLUTTER_VERSION_PATCH 0 PARENT_SCOPE)
set(FLUTTER_VERSION_BUILD 1 PARENT_SCOPE)

# Environment variables to pass to tool_backend.sh
list(APPEND FLUTTER_TOOL_ENVIRONMENT
  "FLUTTER_ROOT=/home/hackman/development/flutter"
  "PROJECT_DIR=/home/hackman/development2/my_app"
  "DART_OBFUSCATION=false"
  "TRACK_WIDGET_CREATION=true"
  "TREE_SHAKE_ICONS=false"
  "PACKAGE_CONFIG=/home/hackman/development2/my_app/.dart_tool/package_config.json"
  "FLUTTER_TARGET=/home/hackman/development2/my_app/lib/main.dart"
)
