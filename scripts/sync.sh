#!/usr/bin/env bash

dir=$(dirname $0)

rsync --delete -avL $@ --filter="merge $dir/config.filter" ~/.config/ ~/.dotfiles/.config
rsync --delete -avL $@ --filter="merge $dir/user.filter" ~/ ~/.dotfiles/
