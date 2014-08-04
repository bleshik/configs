if [ -x ~/.bashrc ] ; then
    . ~/.bashrc
fi

if [ ! -z "$SSH_AUTH_SOCK" ] ; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
else
    ssh-agent bash
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/bleshik/.gvm/bin/gvm-init.sh" ]] && source "/Users/bleshik/.gvm/bin/gvm-init.sh"
