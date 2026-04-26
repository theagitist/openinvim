# OpenInVim

macOS AppleScript droplet app that opens files from Finder in Vim inside tmux/iTerm.

## Build & Install

```bash
./build.sh      # Compile AppleScript into OpenInVim.app
./install.sh    # Build + copy to /Applications
```

## Architecture

- **OpenInVim.applescript** — The entire app logic. An AppleScript droplet that receives files via `on open`, builds vim args, and either creates a tmux window or a `.command` file for iTerm.
- **Info.plist** — Declares the app as an editor for all file types (`*` extension). Bundle ID: `com.local.openinvim`.
- **droplet.icns** — Custom app icon.
- **build.sh** — Uses `osacompile` to build the `.app` bundle, then overlays our Info.plist and icon.

## Key details

- Hardcoded to `/opt/homebrew/bin/vim` and `/opt/homebrew/bin/tmux` (Homebrew on Apple Silicon)
- Uses iTerm as the terminal app
- tmux window is named after the first file opened
- Without tmux, uses a self-deleting `.command` file trick to open vim in iTerm
