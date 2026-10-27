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

## System configuration

### Layout

The system packages live in `system/`, which has its own dotter configuration.
They are deployed from a separate clone owned by root, so `/etc` never links into a user's home directory.

```
GitHub                       origin
  |  clone as user
~/.../configuration          for editing
  |  pull as root
/opt/configuration           what /etc actually links to
```

| Repository            | Creation                  | Role      |
| --------------------- | ------------------------- | --------- |
| GitHub                |                           | origin    |
| `~/.../configuration` | clone as user from GitHub | editing   |
| `/opt/configuration`  | clone as root from user   | deploying |

> NOTE: The root clone needs to be cloned with `--no-hardlinks`.

Deploy as root from the `system/` directory of the root clone:

```sh
cd /opt/configuration/system
dotter deploy
```

### Portability

The system packages assume Arch and glibc to varying degrees, and two of them do not travel at all.

`pacman` and `paru` are Arch only, and `mkinitcpio` nearly so.

`locale` is glibc only.

The rest, `console`, `grub`, `pam`, `systemd`, `docker` and `udev`, are about the kernel, systemd or a
specific daemon, and care about neither the distribution nor the libc.

### What cannot be deployed

Not everything on a system is a file you can symlink, and a few files are a bad idea to symlink here.

- **Login shells** live in `/etc/passwd`, which is a database, not configuration. Handled by the `shell` package, which keeps one entry per account.
- **Timezone** is `/etc/localtime`, a symlink into `/usr/share/zoneinfo` rather than a file with contents. Handled by the `timezone` package.
- **Users and groups** likewise: `useradd -m -G wheel,input,docker nelli && passwd nelli`.
- **Hostname** differs per machine: `hostnamectl hostname <name>`.
- **`/etc/fstab`** holds this machine's partition UUIDs and cannot be shared.
- **`/etc/sudoers.d`** must be owned by root, and sudo refuses files that are not.
- **Enabled services** are symlinks that `systemctl enable` manages under `/etc/systemd/system`.
  Deploying them would fight with systemd, so keep a list instead.

Currently enabled beyond the defaults:
`NetworkManager`, `systemd-resolved`, `systemd-timesyncd`, `systemd-oomd`, `bluetooth`, `cups`, `avahi-daemon`, `docker`, `tailscaled`, `waydroid-container`, `fstrim.timer`.

### Ideas

Still on the list:

- A GRUB theme. `GRUB_THEME` is in place but commented out, and `GRUB_GFXMODE` wants pinning to a real resolution first.
- A keyboard layout. `libxkbcommon` searches `/etc/xkb/symbols` before `/usr/share/X11/xkb`, so a custom layout is deployable as its own package.
- A login manager
- Root's own configuration. `/root` is deployable the same way as `/etc`.
- A console font. Left out for now because the right size depends entirely on the panel.

Worth adding at some point:

- `packages.txt` from `pacman -Qqe`, so a new machine is one `pacman -S --needed - < packages.txt` away.
- `/etc/sysctl.d` drop-ins for kernel tunables.
- `/etc/modprobe.d` for blacklisting and module options.
- `/etc/systemd/zram-generator.conf`, which would replace the swap file and make the `zswap.enabled=0` kernel parameter moot.
- `/etc/xdg/reflector/reflector.conf` so the mirrorlist stays fresh on its own.
- `/etc/makepkg.conf.d` for parallel builds and ccache.
- `/etc/skel`, which decides what a newly created user starts with.
- `/etc/systemd/system/<unit>.d` overrides, for the times a shipped unit is almost right.

## External Content

### Wallpapers

All wallpapers are taken from the [Rosé Pine Wallpaper repository](https://github.com/rose-pine/wallpapers) and are not licensed from here.

### Textadept LSP module

The LSP module in `textadept/configuration/textadept/modules/lsp/` is copied unmodified from the [Textadept 13.0 modules release](https://github.com/orbitalquark/textadept/releases/tag/textadept_13.0) and is not licensed from here.
