#!/bin/sh

for file in './vim/snippets/*'
do
  $(ln -f ${file} ~/.vim/snippets)
done
