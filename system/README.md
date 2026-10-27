# system-configuration

System level configuration for my machines, deployed with [dotter](https://github.com/SuperCuber/dotter).

## Layout

```
GitHub                            origin
  |  clone as user
~/.../system-configuration        for editing
  |  pull as root
/opt/system-configuration         what /etc actually links to
```

| Repository                   | Creation                  | Role      |
| ---------------------------- | ------------------------- | --------- |
| Github                       |                           | origin    |
| `~/.../system-configuration` | clone as user from GitHub | editing   |
| `/.../system-configuration`  | clone as root from user   | deploying |

> NOTE: The system level repo needs to be cloned with `--no-hardlinks`.

### Portability

The packages here assume Arch and glibc to varying degrees, and two of them do not travel at all.

`pacman` and `paru` are Arch only, and `mkinitcpio` nearly so.

`locale` is glibc only.

The rest, `console`, `grub`, `pam`, `systemd`, `docker` and `udev`, are about the kernel, systemd or a
specific daemon, and care about neither the distribution nor the libc.

## What cannot be deployed

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

## Ideas

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
