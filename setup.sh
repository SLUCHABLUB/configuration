#!/usr/bin/env bash

# Applies the parts of this configuration that are not files, and so cannot be stowed.
# Both steps check the current state first, so a second run reports and changes nothing.

set -o errexit
set -o nounset
set -o pipefail

readonly timezone="Europe/Stockholm"
readonly login_shell="/usr/bin/bash"

# The account to set the login shell on.
# Defaults to whoever invoked the script, which under sudo is the original user rather than root.
if [[ $# -gt 0 ]]; then
	account="$1"
elif [[ -n "${SUDO_USER:-}" ]]; then
	account="${SUDO_USER}"
else
	account="$(id --user --name)"
fi
readonly account

# Both timedatectl and chsh need root, so ask for it once up front rather than per command.
if [[ "${EUID}" -ne 0 ]]; then
	echo "Needs root, re-running under sudo."
	exec sudo "$0" "${account}"
fi

if ! getent passwd "${account}" > /dev/null; then
	echo "No such account: ${account}" >&2
	exit 1
fi

# The timezone is the symlink at /etc/localtime pointing into /usr/share/zoneinfo.
# Stow refuses to place an absolute symlink out of a package, so it is set here instead.
current_timezone="$(timedatectl show --property=Timezone --value)"
if [[ "${current_timezone}" == "${timezone}" ]]; then
	echo "Timezone is already ${timezone}."
else
	echo "Setting timezone from ${current_timezone} to ${timezone}."
	timedatectl set-timezone "${timezone}"
fi

# The login shell lives in /etc/passwd, which is a database rather than configuration.
current_shell="$(getent passwd "${account}" | cut --delimiter=: --fields=7)"
if [[ "${current_shell}" == "${login_shell}" ]]; then
	echo "Login shell for ${account} is already ${login_shell}."
elif ! grep --quiet --line-regexp --fixed-strings "${login_shell}" /etc/shells; then
	# chsh refuses any shell that /etc/shells does not list, and says little about why.
	echo "${login_shell} is not listed in /etc/shells, so chsh would refuse it." >&2
	exit 1
else
	echo "Changing login shell for ${account} from ${current_shell} to ${login_shell}."
	chsh --shell "${login_shell}" "${account}"
fi
