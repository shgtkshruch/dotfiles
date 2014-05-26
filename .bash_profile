#!/usr/bin/env bash

# bash_prompt
# Bash prompt customization
# https://gist.github.com/jmblog/d8f73c00f2705717940a 

# Check that terminfo exists before changing TERM var to xterm-256color
# Prevents prompt flashing in Mac OS X 10.6 Terminal.app
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
fi
 
# Turn off standout; turn off underline
tput sgr 0 0
 
# Base styles and color palette
# If you want to check color code, run `./testcolor.sh'
BOLD=$(tput bold)
RESET=$(tput sgr0)
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 255)
ORANGE=$(tput setaf 172)
 
style_user="\[${RESET}${ORANGE}\]"
style_host="\[${RESET}${YELLOW}\]"
style_path="\[${RESET}${GREEN}\]"
style_chars="\[${RESET}${WHITE}\]"
style_branch="${CYAN}"
 
if [[ "$SSH_TTY" ]]; then
    # connected via ssh
    style_host="\[${BOLD}${RED}\]"
elif [[ "$USER" == "root" ]]; then
    # logged in as root
    style_user="\[${BOLD}${RED}\]"
fi
 
is_git_repo() {
    $(git rev-parse --is-inside-work-tree &> /dev/null)
}
 
is_git_dir() {
    $(git rev-parse --is-inside-git-dir 2> /dev/null)
}
 
get_git_branch() {
    local branch_name
 
    # Get the short symbolic ref
    branch_name=$(git symbolic-ref --quiet --short HEAD 2> /dev/null) ||
    # If HEAD isn't a symbolic ref, get the short SHA
    branch_name=$(git rev-parse --short HEAD 2> /dev/null) ||
    # Otherwise, just give up
    branch_name="(unknown)"
 
    printf $branch_name
}
 
# Git status information
prompt_git() {
    local git_info git_state uc us ut st
 
    if ! is_git_repo || is_git_dir; then
        return 1
    fi
 
    git_info=$(get_git_branch)
 
    # Check for uncommitted changes in the index
    if ! $(git diff --quiet --ignore-submodules --cached); then
        uc="+"
    fi
 
    # Check for unstaged changes
    if ! $(git diff-files --quiet --ignore-submodules --); then
        us="!"
    fi
 
    # Check for untracked files
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        ut="?"
    fi
 
    # Check for stashed files
    if $(git rev-parse --verify refs/stash &>/dev/null); then
        st="$"
    fi
 
    git_state=$uc$us$ut$st
 
    # Combine the branch name and state information
    if [[ $git_state ]]; then
        git_info="$git_info[$git_state]"
    fi
 
    printf "${WHITE} on ${style_branch}${git_info}"
}
 
 
# Set the terminal title to the current working directory
PS1="\[\033]0;\w\007\]"
# Build the prompt
PS1+="\n" # Newline
PS1+="${style_user}\u" # Username
PS1+="${style_chars}@" # @
PS1+="${style_host}\h" # Host
PS1+="${style_chars}: " # :
PS1+="${style_path}\w" # Working directory
PS1+="\$(prompt_git)" # Git details
PS1+="\n" # Newline
PS1+="${style_chars}\$ \[${RESET}\]" # $ (and reset color)



# Path
export PATH=/usr/local/bin:$PATH
export BUNDLER_EDITOR=vim

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"



# Alias
alias amz="$HOME/bin/aws.sh"
alias ansiblep='ansible-playbook'
alias be='bundle exec'
alias bi='bundle install --path vendor/bundle'
alias bl='bundle list'
alias bo='bundle open'
alias bs='bundle show'
alias bri='brew install'
alias brl='brew list'
alias brs='brew search'
alias bru='brew update'
alias brui='brew uninstall'
alias brci='brew cask install'
alias brcl='brew cask list'
alias brcs='brew cask search'
alias brcui='brew cask uninstall'
alias diary="$HOME/bin/diary.sh"
alias gs='gitsh'
alias ls="ls -GAF"
alias ll="ls -l"
alias sed='gsed'
alias slide="$HOME/bin/slide.sh"
alias sszip="$HOME/bin/zip.sh"
alias ssrar="$HOME/bin/rar.sh"
alias t='trash'



# z.sh
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}



# Application
# aws-cli
complete -C aws_completer aws

# bash_completion
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  source /usr/local/etc/bash_completion.d/git-completion.bash
fi

if [ -f /usr/local/etc/bash_completion.d/rails.bash ]; then
  source /usr/local/etc/bash_completion.d/rails.bash
fi

if [ -f /usr/local/etc/bash_completion.d/vagrant ]; then
  source /usr/local/etc/bash_completion.d/vagrant
fi

if [ -f /usr/local/etc/bash_completion.d/hub.bash_completion.sh ]; then
  source /usr/local/etc/bash_completion.d/hub.bash_completion.sh
fi



# git
function u()
{
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}

# hub
eval "$(hub alias -s)"

