#!/usr/bin/env bash

dir=$(dirname $0)

rsync -avL $@ --filter="merge $dir/config.filter" ~/.config/ ~/.dotfiles/.config
rsync -avL $@ --filter="merge $dir/user.filter" ~/ ~/.dotfiles/
