function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cg peco_select_ghq_repository
end

alias vim 'reattach-to-user-namespace vim'

set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
