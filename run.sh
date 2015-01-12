test -z $(which brew) && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew instll ansible
ansible-playbook playbook.yml -i host
