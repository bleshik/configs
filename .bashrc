#if [ ! -z "$SSH_AUTH_SOCK" ] ; then
    #ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
#else
    #ssh-agent bash
#fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
PS1="\`if [ \$? = 0 ] ; then echo '\[\e[35;1m\]\!:\[\e[0;32m\](\[\e[30;1m\]\u@\h\[\e[0;32m\]|\[\e[30;1m\]\j\[\e[0;32m\]|\[\e[30;1m\]\w\[\e[0;32m\])->\[\e[0m\]' ; else echo '\[\e[35;1m\]\!:\[\e[31;1m\](\[\e[30;1m\]\u@\h\[\e[31;1m\]|\[\e[30;1m\]\j\[\e[31;1m\]|\[\e[30;1m\]\w\[\e[31;1m\])->\[\e[0m\]' ; fi\`"
#unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)

if [ ! -z "`command -v tmux`" ] ; then
    alias tmux="TERM=xterm-256color tmux"
fi

if [ -f ~/.bashrc_additional ] ; then
    source ~/.bashrc_additional
fi

if [ -f ~/.ssh/config ] ; then
    complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

SDKMAN_INIT=false
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export EDITOR=vim
export GIT_EDITOR=vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
source ~/.git-completion.bash
source ~/.gradle-tab-completion.bash
export GRADLE_USER_HOME="$HOME"
[[ -d "~/.bash_plugin" ]] && source ~/.bash_plugins/*

PATH=/Applications/MacVim.app/Contents/MacOS:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/.scripts_additional/bash
PATH=$PATH:$HOME/.git-hooks
PATH=$PATH:$HOME/K/risk/multi-tool
PATH=$PATH:/usr/local/bin
PATH=$HOME/.config/yarn/global/node_modules/.bin:$PATH
PATH=$HOME/.scripts/bash:$PATH
PATH=$HOME/Library/Python/2.7/bin/:$PATH
PATH=$HOME/Library/Python/3.6/bin/:$PATH
PATH=./node_modules/.bin:$PATH
export AWS_CBOR_DISABLE=1
export GRADLE_USER_HOME="$HOME"

function notifyLastCommand {
    CODE=$?
    if [ "$CODE" = "0" ] ; then
        TITLE="Success"
    else
        TITLE="Failure ($CODE)"
    fi
    notify "`fc -ln -1 | xargs` is done
at $PWD" "$TITLE" &
    disown
    return $CODE
}

function currentGitBranch {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

function nodebugJavaOpts {
    echo "$JAVA_OPTS" | sed -e 's/ *-Xdebug */ /g' | sed -e 's/ *-Xrunjdwp.*address=[^ ]* */ /g'
}

function grails {
    GRAILS_OPTS="$GRAILS_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=`find_free_port.sh 5005 1`" ~/.sdkman/candidates/grails/current/bin/grails -reloading "$@" --verbose --stacktrace | tee >(while read line; do if [ ! -z "`echo $line | grep 'Server running'`" ] ; then notify "`echo $line | sed -e 's/.*http/http/g'`" "Server running" ; fi ; done) ; test ${PIPESTATUS[0]} -eq 0
    notifyLastCommand
    CODE=$?
    #ctags -a -R -f "target/`currentGitBranch`/.tags" "target/`currentGitBranch`/plugins"
    return $CODE
}

function groovy {
    JAVA_OPTS="`nodebugJavaOpts` -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=`find_free_port.sh 12005 1`" ~/.sdkman/candidates/groovy/current/bin/groovy "$@"
    notifyLastCommand
}

function groovysh {
    JAVA_OPTS="`nodebugJavaOpts` -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=`find_free_port.sh 11005 1`" ~/.sdkman/candidates/groovy/current/bin/groovysh "$@"
}

function java {
    JAVA_OPTS="`nodebugJavaOpts` -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=`find_free_port.sh 10005 1`" "$JAVA_HOME/bin/java" "$@"
    notifyLastCommand
}

function javac {
    JAVA_OPTS="`nodebugJavaOpts` -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=`find_free_port.sh 7005 1`" "$JAVA_HOME/bin/javac" "$@"
    notifyLastCommand
}

function sbt {
    JAVA_OPTS="`nodebugJavaOpts` -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=`find_free_port.sh 6005 1`" "/usr/local/bin/sbt" "$@"
    notifyLastCommand
}

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
function multi-tool { docker run -it --rm -e "MT_MODE=term" -e "SQL_HOST=`(ifconfig vboxnet0; ifconfig vboxnet1; ifconfig vboxnet2) | grep "inet " | cut -d ' ' -f2 | grep "$(boot2docker ip | sed -e 's/.[0-9]*$//g')"`" -v ~/multi-tool:/root/multi-tool riskmatch/multitool; }

# Create tags for the JDK
function ctagsJava {
    cd $JAVA_HOME && [ ! -f .tags ] && [ -f src.zip ] && unzip -od src src.zip && echo "Tagging JDK..." && ctags -a -f .tags -R src
}
