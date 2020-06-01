#!/bin/bash

i3status --config ~/.config/i3/i3status.conf | while :
do
        read line
        LAYOUT=$(setxkbmap -query | awk '/layout/{print $2}')
        echo "kb: $LAYOUT | $line" || exit 1
done
