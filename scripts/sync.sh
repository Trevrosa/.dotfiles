#!/usr/bin/env bash

dir=$(dirname $0)

rsync --delete -avL $@ --filter="merge $dir/config.filter" ~/.config/ ~/.dotfiles/.config
rsync --delete -avL $@ --filter="merge $dir/user.filter" ~/ ~/.dotfiles
rsync --delete -avL --mkpath $@ /etc/udev/rules.d/ ~/.dotfiles/udev/rules.d
# ensure sudoer rule for the path
sudo rsync --delete -avL --mkpath --no-perms $@ /etc/polkit-1/rules.d/ ~/.dotfiles/polkit/rules.d
rsync --delete -avL --mkpath $@ /etc/NetworkManager/dispatcher.d/user/ ~/.dotfiles/NetworkManager/dispatcher.d
