# system-configuration

System level configuration for my machines, managed with GNU Stow.


## Installing

```sh
sudo pacman -S --needed stow
sudo git clone git@github.com:SLUCHABLUB/system-configuration.git /opt/system-configuration
cd /opt/system-configuration
sudo stow pacman paru locale console mkinitcpio grub pam systemd docker udev
sudo ./setup.sh
```

Some packages need a command afterwards:

| Package      | After stowing                               |
| ------------ | ------------------------------------------- |
| `locale`     | `sudo locale-gen`, and this package must be stowed first, see below |
| `mkinitcpio` | `sudo mkinitcpio -P`                        |
| `grub`       | `sudo grub-mkconfig -o /boot/grub/grub.cfg` |
| `docker`     | `sudo systemctl restart docker`             |
| `udev`       | `sudo udevadm control --reload`             |
| `systemd`    | takes effect on reboot                      |
| `console`    | takes effect on reboot                      |
| `pam`        | takes effect at the next login              |

`setup.sh` applies the two settings that are not files at all, the timezone and the login shell.
Both are idempotent, so it is safe to rerun and it reports when there is nothing to do.

### Working in a root owned clone

Git refuses to touch a repository owned by someone else, so tell it this one is fine:

```sh
git config --global --add safe.directory /opt/system-configuration
```

That is enough to read the log and the diff. Writing needs sudo, and plain `sudo git commit` would author the
commit as root, which has no name or email configured. Keep your own identity by keeping your home directory:

```sh
sudo --preserve-env=HOME git commit
```

## Packages

| Package      | Contents                                                                    |
| ------------ | --------------------------------------------------------------------------- |
| `pacman`     | Repositories, parallel downloads, signature levels.                          |
| `paru`       | AUR helper behaviour.                                                        |
| `locale`     | A locale defined here: English words, ISO dates, Swedish sorting and currency. |
| `console`    | Swedish keymap for the virtual consoles and for XKB.                         |
| `mkinitcpio` | Initramfs hooks, including `keymap` so the layout works at the boot prompt.  |
| `grub`       | Boot menu and kernel command line.                                          |
| `pam`        | Fingerprint unlocking and GNOME keyring unlocking.                           |
| `systemd`    | Drop-ins for logind (power key) and resolved (DNS over TLS).                 |
| `docker`     | Leaves the `FORWARD` chain policy alone so it does not break other routing.  |
| `udev`       | Non-root access to the ULX3S FPGA board.                                     |

### Portability

The packages here assume Arch and glibc to varying degrees, and two of them do not travel at all.

`pacman` and `paru` are Arch only, and `mkinitcpio` nearly so.

`locale` is glibc only.

The rest, `console`, `grub`, `pam`, `systemd`, `docker` and `udev`, are about the kernel, systemd or a
specific daemon, and care about neither the distribution nor the libc.

## What cannot be stowed

Not everything on a system is a file you can symlink, and a few files are a bad idea to symlink here.

- **Default shell** lives in `/etc/passwd`, which is a database, not configuration. Handled by `setup.sh`.
- **Timezone** is `/etc/localtime`, a symlink into `/usr/share/zoneinfo`, and stow refuses absolute symlinks inside a package. Handled by `setup.sh`.
- **Users and groups** likewise: `useradd -m -G wheel,input,docker nelli && passwd nelli`.
- **Hostname** differs per machine: `hostnamectl hostname <name>`.
- **`/etc/fstab`** holds this machine's partition UUIDs and cannot be shared.
- **`/etc/sudoers.d`** must be owned by root, and sudo refuses files that are not.
- **Enabled services** are symlinks that `systemctl enable` manages under `/etc/systemd/system`.
  Stowing them would fight with systemd, so keep a list instead.

Currently enabled beyond the defaults:
`NetworkManager`, `systemd-resolved`, `systemd-timesyncd`, `systemd-oomd`, `bluetooth`, `cups`, `avahi-daemon`, `docker`, `tailscaled`, `waydroid-container`, `fstrim.timer`.

## Ideas

Still on the list:

- A GRUB theme. `GRUB_THEME` is in place but commented out, and `GRUB_GFXMODE` wants pinning to a real resolution first.
- A keyboard layout. `libxkbcommon` searches `/etc/xkb/symbols` before `/usr/share/X11/xkb`, so a custom layout is stowable as its own package.
- A login manager
- Root's own configuration. `/root` is stowable the same way as `/etc`.
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
