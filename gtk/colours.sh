#!/bin/sh

# The colours of libadwaita and the Tilia colours they are set to.
# They are named as the CSS variables of libadwaita, without the leading dashes.
# Only colours are set, since other styles such as borders break many interfaces.

# shellcheck disable=SC2034 # Used by the templates that source this file.
gtk_colours="
window-bg-color                  primary-background
window-fg-color                  text
view-bg-color                    secondary-background
view-fg-color                    text
headerbar-bg-color               primary-background
headerbar-fg-color               text
headerbar-backdrop-color         primary-background
headerbar-border-color           border
overview-bg-color                primary-background
overview-fg-color                text
sidebar-bg-color                 secondary-background
sidebar-fg-color                 text
sidebar-backdrop-color           secondary-background
sidebar-border-color             border
secondary-sidebar-bg-color       tertiary-background
secondary-sidebar-fg-color       text
secondary-sidebar-backdrop-color tertiary-background
secondary-sidebar-border-color   border
card-bg-color                    secondary-background
card-fg-color                    text
thumbnail-bg-color               secondary-background
thumbnail-fg-color               text
dialog-bg-color                  tertiary-background
dialog-fg-color                  text
popover-bg-color                 tertiary-background
popover-fg-color                 text
border-color                     border
accent-color                     purple
accent-bg-color                  purple
accent-fg-color                  primary-background
destructive-color                red
destructive-bg-color             red
destructive-fg-color             primary-background
error-color                      red
error-bg-color                   red
error-fg-color                   primary-background
success-color                    green
success-bg-color                 green
success-fg-color                 primary-background
warning-color                    yellow
warning-bg-color                 yellow
warning-fg-color                 primary-background
"
