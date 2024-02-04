#!/usr/bin/env bash

ln -sfv "/Users/denisdreano/repos/dotfiles/.Rprofile" ~
ln -sfv "/Users/denisdreano/repos/dotfiles/.zshrc" ~

rm -r ~/.config/kitty
ln -sfv "/Users/denisdreano/repos/dotfiles/kitty/" ~/.config/kitty

rm -r ~/.config/tmux
ln -sfv "/Users/denisdreano/repos/dotfiles/tmux/" ~/.config/tmux

rm -r ~/.config/nvim
ln -sfv "/Users/denisdreano/repos/dotfiles/nvim/" ~/.config/nvim

rm -r ~/.config/zsh
ln -sfv "/Users/denisdreano/repos/dotfiles/zsh/" ~/.config/zsh
