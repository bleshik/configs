[ -f ~/.bashrc ] && source ~/.bashrc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/abalchunas/.sdkman"
[[ -s "/Users/abalchunas/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/abalchunas/.sdkman/bin/sdkman-init.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/abalchunas/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/abalchunas/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/abalchunas/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/abalchunas/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=$PATH:/usr/local/bin
