# Path
export PATH=/usr/local/bin:$PATH

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"



# Alias
alias be='bundle exec'
alias gs='gitsh'
alias ansiblep='ansible-playbook'
alias sed='gsed'
alias slide="$HOME/bin/slide.sh"
alias amz="$HOME/bin/aws.sh"
alias diary="$HOME/bin/diary.sh"
alias sszip="$HOME/bin/zip.sh"
alias ssrar="$HOME/bin/rar.sh"


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
