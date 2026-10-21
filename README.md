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
- clipboard manager (copied text disappears when the program it was copied from exits, e.g. wl-clip-persist)

## Building

Run `./build` to compile every `*.esh` template under the repo. Templates whose basename contains the literal token `MODE` are dual-mode and produce two outputs (`dark` and `light` substituted in). Everything else is a single-output template.

The bat theme is the one exception that needs a manual step after generation: run `bat cache --build` once the generated `.tmTheme` files are in `~/.config/bat/themes/` so bat picks them up.

## Deploying

The files are deployed with [dotter](https://github.com/SuperCuber/dotter), from the root of the repository:

```sh
./build && dotter deploy
```

## Wallpapers

All wallpapers are taken from the [Rosé Pine Wallpaper repository](https://github.com/rose-pine/wallpapers) and are not licensed from here.

## Textadept LSP module

The LSP module in `textadept/.textadept/modules/lsp/` is copied unmodified from the [Textadept 13.0 modules release](https://github.com/orbitalquark/textadept/releases/tag/textadept_13.0) and is not licensed from here.
