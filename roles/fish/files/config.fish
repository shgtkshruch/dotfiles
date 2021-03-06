function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cg peco_select_ghq_repository
end

alias vim 'reattach-to-user-namespace vim'
alias tb 'tig blame (git ls | peco)'

set PATH $HOME/.rbenv/shims $PATH

export EDITOR=vim
eval (direnv hook fish)
