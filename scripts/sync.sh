#!/usr/bin/env bash

dir=$(dirname $0)

rsync --delete -avL $@ --filter="merge $dir/config.filter" ~/.config/ ~/.dotfiles/.config
rsync --delete -avL $@ --filter="merge $dir/user.filter" ~/ ~/.dotfiles
rsync --delete -avL $@ /etc/udev/rules.d/ ~/.dotfiles/udev
rsync --delete -avL $@ /etc/polkit-1/rules.d/ ~/.dotfiles/polkit
