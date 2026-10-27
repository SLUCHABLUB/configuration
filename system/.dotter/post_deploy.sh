#!/bin/sh

# Regenerates whatever the deployed files are an input to, and applies the settings
# that are not files at all.
# Dotter runs this after every deploy, including one that changed nothing,
# so every step below checks first and stays quiet when there is nothing to do.

set -eu

# True when the output is missing or older than the input.
# The inputs are symlinks into the repository, and -nt follows them.
stale() {
	input="$1"
	output="$2"

	[ -e "$input" ] || return 1
	[ ! -e "$output" ] || [ "$input" -nt "$output" ]
}

{{#if dotter.packages.locale}}
if stale /etc/locale.gen /usr/lib/locale/locale-archive; then
	echo "Generating locales."
	locale-gen
fi
{{/if}}

{{#if dotter.packages.mkinitcpio}}
if stale /etc/mkinitcpio.conf /boot/initramfs-linux.img; then
	echo "Rebuilding the initramfs."
	mkinitcpio -P
fi
{{/if}}

{{#if dotter.packages.grub}}
if stale /etc/default/grub /boot/grub/grub.cfg; then
	echo "Regenerating the GRUB configuration."
	grub-mkconfig -o /boot/grub/grub.cfg
fi
{{/if}}

{{#if dotter.packages.udev}}
echo "Reloading udev rules."
udevadm control --reload
{{/if}}

{{#if dotter.packages.docker}}
if systemctl is-active --quiet docker; then
	echo "Restarting docker."
	systemctl restart docker
fi
{{/if}}

{{#if dotter.packages.timezone}}
current_timezone="$(timedatectl show --property=Timezone --value)"

if [ "$current_timezone" != "{{timezone}}" ]; then
	echo "Setting the timezone from $current_timezone to {{timezone}}."
	timedatectl set-timezone "{{timezone}}"
fi
{{/if}}

{{#if dotter.packages.shell}}
# chsh is the only supported way to write the shell field of /etc/passwd.
set_login_shell() {
	account="$1"
	login_shell="$2"

	current_shell="$(getent passwd "$account" | cut --delimiter=: --fields=7)"

	if [ -z "$current_shell" ]; then
		echo "There is no account called $account on this machine, leaving its login shell alone." >&2
		return 0
	fi

	if [ "$current_shell" = "$login_shell" ]; then
		return 0
	fi

	# On some systems, chsh only *warns* on invalid shells.
	if ! grep --quiet --line-regexp --fixed-strings "$login_shell" /etc/shells; then
		echo "$login_shell is not listed in /etc/shells." >&2
		exit 1
	fi

	if [ ! -x "$login_shell" ]; then
		echo "$login_shell is not executable." >&2
		exit 1
	fi

	echo "Changing the login shell for $account from $current_shell to $login_shell."
	chsh --shell "$login_shell" "$account"
}

{{#each login_shells as |login_shell account|}}
set_login_shell "{{account}}" "{{login_shell}}"
{{/each}}
{{/if}}
