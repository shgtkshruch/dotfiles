#!/bin/sh

dotfiles_dir=$PWD

# # vimrc
$(ln -sf ${dotfiles_dir}/vimrc ~/.vimrc)

# vim snippets
for file in './vim/snippets/*'
do
  $(ln -sf ${dotfiles_dir}/${file} ~/.vim/snippets)
done
