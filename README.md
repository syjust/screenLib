# GNU Screen Configuration Framework

Modular GNU Screen setup with vim-style keybindings, per-project session management, and helper scripts for window/layout automation.

## Installation

Clone into your home directory:

```bash
git clone <repo-url> ~/.screen
```

Source the framework from your `~/.screenrc`:

```bash
echo 'source ~/.screen/main.screenrc' > ~/.screenrc
```

### Environment variables

Add these to your `~/.bashrc` (or `~/.zshrc`) to override defaults:

```bash
# Root directory where your project folders live (default: ~/projects/)
export SCREEN_PROJ_DIR="$HOME/projects"

# Template used when generating project sessions (default: ~/.screen/templates/default-template.screenrc)
export SCREEN_TEMPLATE="$HOME/.screen/templates/default-template.screenrc"
```

When you start a screen session whose name matches a folder in `$SCREEN_PROJ_DIR`, a session file is auto-generated from the template and sourced. For example:

```bash
screen -S myapp   # creates ~/.screen/project_sessions/myapp.screenrc from the template
```

## Keybindings

All bindings use the default `^a` prefix unless noted.

### Focus & resize (`bind/focus.screenrc`)

| Binding | Action |
|---|---|
| `^a ^h` / `^a ^j` / `^a ^k` / `^a ^l` | Vim-style focus navigation (left/down/up/right) |
| `^a /` | Equalize all pane sizes |
| `Shift+Right` / `Shift+Left` | Resize pane by +/-20 (no prefix needed) |

### Extended window selection (`bind/windows.screenrc`)

| Binding | Action |
|---|---|
| `^a - [0-9]` | Jump to window 10-19 |
| `^a = [0-9]` | Renumber current window to 0-9 |
| `^a # [0-9]` | Renumber current window to 20-29 |

### Macros (`bind/macros.screenrc`)

| Binding | Action |
|---|---|
| `^a +` | Create a trio of windows (Code/GIT/RUN) for a project |
| `^a }` | Kill all windows to the right of the current one |

## Status bar colors

The status bar color indicates the environment type. The active one is set in `main.screenrc`:

- **Blue** — local dev
- **Yellow** — remote dev
- **Magenta** — preprod
- **Red** — production

Override it in a custom file (see below).

## Custom overrides

The `custom/` directory holds machine-specific configuration that is gitignored. All `*.screenrc` files in this directory are auto-sourced in alphabetical order at startup.

To get started, copy the provided samples:

```bash
cp ~/.screen/custom/status.screenrc.sample ~/.screen/custom/status.screenrc
cp ~/.screen/custom/tabs.screenrc.sample   ~/.screen/custom/tabs.screenrc
```

Then edit them to match your machine. You can add any number of `*.screenrc` files — prefix with numbers (e.g. `00-status.screenrc`, `10-tabs.screenrc`) to control sourcing order.

## Project structure

```
~/.screen/
├── main.screenrc              # Entry point sourced by ~/.screenrc
├── bind/
│   ├── focus.screenrc         # Vim-style focus & resize bindings
│   ├── windows.screenrc       # Extended window selection (10-29)
│   └── macros.screenrc        # Trio creation & kill-right macros
├── bin/
│   ├── make-proj-screen-rc.sh # Auto-generates per-project sessions
│   ├── new-trio.sh            # Interactive: create 3 named windows
│   ├── close-right.sh         # Kill all windows to the right
│   └── source-custom.sh       # Sources custom/*.screenrc files
├── templates/
│   └── default.screenrc       # Template for new project sessions
├── custom/
│   ├── status.screenrc.sample # Sample: status bar override
│   └── tabs.screenrc.sample   # Sample: default tabs/windows
├── project_sessions/          # Generated session files (gitignored)
└── private_projects/          # Private session files (gitignored)
```

## License

[WTFPL](http://www.wtfpl.net/) — Do What The Fuck You Want To Public License. See [LICENSE](LICENSE).
