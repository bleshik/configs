if [ -x ~/.bashrc ] ; then
    . ~/.bashrc
fi

if [ ! -z "$SSH_AUTH_SOCK" ] ; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
else
    ssh-agent bash
fi
