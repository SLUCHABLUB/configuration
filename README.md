# My configuration (dot files)

to-do list:
- diff code-background
- keyboard layout
- rclone systemd unit
- other helium config
- gtk?
- theme KDE apps
    - kdeconnect
    - kdenlive
    - ksudoku
    - kwalletmanager
- theme eza (colours)
- theme prismlauncher
- theme discord (vesktop)
- quickshell?
- split up niri config into smaller files

## Building

Run `./build` to compile every `*.esh` template under the repo. Templates whose basename contains the literal token `MODE` are dual-mode and produce two outputs (`dark` and `light` substituted in). Everything else is a single-output template.

The bat theme is the one exception that needs a manual step after generation: run `bat cache --build` once the generated `.tmTheme` files are in `~/.config/bat/themes/` so bat picks them up.

## Wallpapers

All wallpapers are taken from the [Rosé Pine Wallpaper repository](https://github.com/rose-pine/wallpapers) and are not licensed from here.
