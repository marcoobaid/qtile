#!/bin/bash
# Check for available updates in apt.
# NOTE :: <(cmd) is process substitution. It is different from $(cmd) as it acts like a file
#         rather than the _contents_ of a file.

# UI settings
PENDING_SYMBOL=" "
PENDING_COLOR="#d79921"
NONPENDING_COLOR="#b8bb26"

# Parse out the information we need from a simulated update
# Check for updates from Arch main repo
if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

# Check for updates from AUR
# if ! updates_aur=$(cower -u 2> /dev/null | wc -l); then
if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
    updates_aur=0
fi


if [[ $updates_arch != 0 ]] || [[ $updates_aur != 0 ]]; then
    color="$PENDING_COLOR"
else
    color="$NONPENDING_COLOR"
fi

echo -n "<span font='12' foreground='$color'> $PENDING_SYMBOL $updates_arch/$updates_aur  </span>"
# echo -n "$PENDING_SYMBOL$upgraded/$new/$removed/$held"
