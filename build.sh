#!/bin/bash
set -euo pipefail

APP_NAME="OpenInVim"
APP_DIR="${APP_NAME}.app"
INSTALL_DIR="/Applications"

echo "Building ${APP_NAME}..."

# Clean previous build
rm -rf "${APP_DIR}"

# Compile AppleScript into the app (osacompile creates the bundle structure)
osacompile -o "${APP_DIR}" "${APP_NAME}.applescript"

# Copy our custom Info.plist (overwrite the generated one)
cp Info.plist "${APP_DIR}/Contents/Info.plist"

# Copy custom icon if present
if [ -f droplet.icns ]; then
    cp droplet.icns "${APP_DIR}/Contents/Resources/droplet.icns"
fi

echo "Built ${APP_DIR} successfully."
echo ""
echo "To install, run:"
echo "  cp -r ${APP_DIR} ${INSTALL_DIR}/"
echo ""
echo "Then set it as default for file types via Finder > Get Info > Open with."
