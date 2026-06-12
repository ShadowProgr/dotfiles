# My Dotfiles

Welcome to my dotfiles repository! These configurations are tracked and managed using [yadm](https://yadm.io/) (Yet Another Dotfiles Manager) and cover a complete Wayland-based setup, featuring my custom desktop environment setup alongside my preferred development tools.

## 🛠️ Tools & Configurations

Here is a complete list of the tools and packages configured in these dotfiles:

### Window Manager & Shell
*   **Mango**: A Wayland compositor setup. It features specialized tiling and scroller layouts, custom window rules (including a dedicated scratchpad for the Gemini CLI), and keybinds.
*   **DankMaterialShell (DMS)**: A customized shell/desktop environment interface integrated via systemd and styled dynamically.
*   **XDG Desktop Portal**: Configuration for screen sharing and portal functionality (`xdg-desktop-portal-wlr` and specific Mango portals).

### Terminal & Prompt
*   **Foot**: A fast, lightweight Wayland terminal emulator. Configured with a Gruvbox Material color scheme (`.config/foot/gruvbox-material-colors.ini`).
*   **Zsh**: The primary shell environment (`.zshrc`), customized for daily workflow.
*   **Starship**: A fast, cross-shell prompt to provide a unified and informative terminal prompt.

### Applications & CLI Tools
*   **Firefox**: Deeply customized using `userChrome.css`. Includes modifications for rounded corners, a private window theme, and sidebar tweaks. The `yadm bootstrap` script automatically symlinks this configuration to the active Firefox profile.
*   **Yazi**: A blazing fast terminal file manager configured with `yazi.toml`.
*   **FileManager1 D-Bus service**: Makes "Show in folder" in browsers open Yazi in a Foot window (`.config/org.freedesktop.FileManager1.common/`). Only the config and `yazi-wrapper.sh` are tracked here — the service itself must be built and installed from [org.freedesktop.FileManager1.common](https://github.com/boydaihungst/org.freedesktop.FileManager1.common) (`meson setup build && sudo ninja -C build install`) on each machine.
*   **Git**: Core configuration split for general use, "personal", and "omnistream" contexts.
*   **MPV**: Media player customized with `mpv.conf` and the `modernz` UI script.

### Theming & Appearance
*   **Matugen**: Material You color generation tool. Dynamically creates palettes and templates, such as generating themes for Pywalfox (`.config/matugen/templates/custom-pywalfox.json`).
*   **Backgrounds**: A curated collection of Gruvbox-themed wallpapers stored in `.local/share/backgrounds/`.
*   **Fcitx5**: Configured as the primary input method framework within the Wayland environment (configured via Mango).

## 🚀 Getting Started

To install and apply these dotfiles on a new machine using yadm:

```bash
# Clone and apply the dotfiles
yadm clone <your-repository-url>

# Run the bootstrap script (sets up Firefox userChrome and other initialization tasks)
yadm bootstrap
```
