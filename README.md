# OpenInVim

A lightweight macOS app that lets you open files from Finder directly in Vim, inside your terminal.

When you double-click a file (or use "Open with"), OpenInVim will:

- **If tmux is running:** Open the file in a new tmux window, named after the file, and focus iTerm
- **If tmux is not running:** Open the file in a new iTerm window via a temporary `.command` file

This makes it easy to associate `.md`, `.txt`, `.py`, `.js`, and other code/text files with Vim through Finder's "Open with" feature.

## Requirements

- macOS
- [iTerm2](https://iterm2.com/)
- [Vim](https://www.vim.org/) (installed via Homebrew at `/opt/homebrew/bin/vim`)
- [tmux](https://github.com/tmux/tmux) (optional, installed via Homebrew at `/opt/homebrew/bin/tmux`)

## Install

```bash
git clone https://github.com/yourusername/OpenInVim.git
cd OpenInVim
chmod +x build.sh install.sh
./install.sh
```

This compiles the AppleScript into an app bundle and copies it to `/Applications`.

## Set as default app for file types

1. Right-click any file in Finder (e.g. a `.md` file)
2. Select **Get Info**
3. Under **Open with**, choose **OpenInVim**
4. Click **Change All...** to use it for all files of that type

Repeat for any file extensions you want to open in Vim.

## How it works

OpenInVim is an AppleScript "droplet" — a macOS app that receives files via drag-and-drop or the "Open with" system.

When files are opened:

1. It builds a Vim command with all the file paths as arguments
2. It checks for an active tmux session:
   - **tmux available:** Creates a new tmux window named after the first file and runs Vim there
   - **No tmux:** Creates a self-deleting `.command` file and opens it in iTerm

When launched without files, it simply opens iTerm.

## Build from source

```bash
./build.sh
```

This creates `OpenInVim.app` in the current directory. The build script uses `osacompile` to compile the AppleScript source into a macOS app bundle, then applies the custom `Info.plist` and icon.

## Customization

**Different terminal:** Replace `"iTerm"` with `"Terminal"` (or another terminal app) in `OpenInVim.applescript`.

**Different editor:** Replace `/opt/homebrew/bin/vim` with your editor of choice (e.g. `/opt/homebrew/bin/nvim`).

**Non-Homebrew paths:** If your tools are installed elsewhere, update the paths in the AppleScript (e.g. `/usr/local/bin/vim` for Intel Macs).

## Project structure

```
OpenInVim/
├── OpenInVim.applescript   # Main source code
├── Info.plist              # App bundle metadata and file associations
├── droplet.icns            # App icon
├── build.sh                # Compile into .app bundle
├── install.sh              # Build and install to /Applications
└── README.md
```

## License

MIT
