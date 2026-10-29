# My configuration (dot files)

## Dependencies

- [dotter](https://github.com/SuperCuber/dotter)
    For deploying
- [esh](https://github.com/jirutka/esh)
    For building

Each package may have additional dependencies but these are checked by dotter in pre-deploy.

## Installation

> The deployment locations are read from the `XDG_*_HOME` variables. The deployed `.profile` exports the XDG variables as they were at build time, so later builds from a login shell keep using the same locations.
>
> To use an XDG-user-directories style of naming for the XDG base directories, source `user-style-directories.sh` before running `./build`.

Unless you want to deploy all packages, you can create a custom `local.toml`:
```sh
cp .dotter/local.toml.template .dotter/local.toml
edit .dotter/local.toml
```

```sh
./build
dotter deploy
```

## System Configuration

The system packages live in the `system` directory, which has its own dotter configuration. They are deployed from a separate clone owned by root, so `/etc` never links into a user's home directory.

```
GitHub                       origin
  |  clone as user
~/.../configuration          for editing
  |  pull as root
/.../configuration           what /etc actually links to
```

| Repository            | Creation                  | Role      |
| --------------------- | ------------------------- | --------- |
| GitHub                |                           | origin    |
| `~/.../configuration` | clone as user from GitHub | editing   |
| `/.../configuration`  | clone as root from user   | deploying |

### Installation

> NOTE: The root clone needs to be cloned with `--no-hardlinks`.

For example if the system configuration is put into `/opt` and the user configuration is in `~/Projects`:

```sh
cd /opt
sudo git clone --no-hardlinks ~/Projects/configuration
cd configuration/system
sudo dotter deploy
```

## To-Do List

- fix whatever is going on the the btop config
- move `.shellcheckrc` to the XDG config directory
- a `local.toml` template (both normal and system settings)
- source .profile in bashrc?
- look over fastfetch (it also prints the C locale)
- a clipboard manager or at least wl-clip-persist
- find a nice serif/math font that isn't just the typst default
- make themes more switchable
- a keyboard layout (console && Wayland)
- a console font (of jetbrains mono)
- make parts of the git commit hook skippable

- sudo configuration
- general browser setting
- browser extensions
- the root user's configuration (another clone?)
- `packages.txt` from `pacman -Qqe`
- a package that sets up a user `nelli` and warns if no password is set
- a package that set's the host name from local.toml or that warns if none is set
- list of enabled services that are started by post-deploy
- fstab validation?
- makepkg config
- reflector config (Arch)

### Theme

- gtk
- KDE apps
    - kdeconnect
    - kdenlive
    - ksudoku
    - kwalletmanager
- eza (colours)
- prismlauncher
- discord (vesktop)
- GRUB

- diff background
- font size discrepancies

### Key-Bindings

- kitty: go to the top of scrollback
- bash line editor
- moor (or other page) key-binds

### Potential Additions

- a login manager
- quickshell
- `/etc/skel`
- switch to LibreWolf
- switch shell

- zram
- `/etc/systemd/system/<unit>.d` overrides
- sysctl config
- modprobe config

## External Content

### Wallpapers

All wallpapers are taken from the [Rosé Pine Wallpaper repository](https://github.com/rose-pine/wallpapers) and are not licensed from here.

### Textadept LSP module

The LSP module in `textadept/configuration/textadept/modules/lsp/` is copied unmodified from the [Textadept 13.0 modules release](https://github.com/orbitalquark/textadept/releases/tag/textadept_13.0) and is not licensed from here.
