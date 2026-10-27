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

Run `./build` to compile every `*.esh` template. Templates whose basename contains the literal token `MODE` are dual-mode and produce two outputs (`dark` and `light` substituted in). Everything else is a single-output template.

## Deploying

The files are deployed with [dotter](https://github.com/SuperCuber/dotter), from the root of the repository:

```sh
./build
dotter deploy
```

The deployment locations are read from the `XDG_*_HOME` variables. The deployed `.profile` exports the XDG variables as they were at build time, so later builds from a login shell keep using the same locations.

To use visible directories (`~/Configuration`, `~/Data` and so on) instead, source `visible-directories.sh` before building:

```sh
. ./visible-directories.sh
./build
dotter deploy
```

Each package lists the commands it needs under `[package.variables.commands]` in `.dotter/global.toml.esh`. Before deploying, `.dotter/pre_deploy.sh` checks that every command of the selected packages is installed, and refuses to deploy otherwise.

## External Content

### Wallpapers

All wallpapers are taken from the [Rosé Pine Wallpaper repository](https://github.com/rose-pine/wallpapers) and are not licensed from here.

### Textadept LSP module

The LSP module in `textadept/configuration/textadept/modules/lsp/` is copied unmodified from the [Textadept 13.0 modules release](https://github.com/orbitalquark/textadept/releases/tag/textadept_13.0) and is not licensed from here.
