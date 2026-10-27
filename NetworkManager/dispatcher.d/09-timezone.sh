#!/bin/sh
case "$2" in
    connectivity-change)
	tzupdate
	if [ $? -eq 0 ]; then
		killall -SIGUSR2 waybar
	fi
    ;;
esac
