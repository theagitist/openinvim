#!/bin/bash
set -euo pipefail

APP_NAME="OpenInVim"
INSTALL_DIR="/Applications"

# Build first
./build.sh

echo ""
echo "Installing to ${INSTALL_DIR}..."
rm -rf "${INSTALL_DIR}/${APP_NAME}.app"
cp -r "${APP_NAME}.app" "${INSTALL_DIR}/"
rm -rf "${APP_NAME}.app"
echo "Installed ${APP_NAME}.app to ${INSTALL_DIR}/"
echo ""
echo "Next steps:"
echo "  1. Right-click any file in Finder > Get Info"
echo "  2. Under 'Open with', select OpenInVim"
echo "  3. Click 'Change All...' to apply to all files of that type"
