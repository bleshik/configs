function callvim
{
  if [ -z `vim --serverlist | grep VIM` ] ; then
     mvim $@
  else
      if [ ! -z "$@" ] ; then
          vim --remote $@
      fi
      if typeset -f postCallVim > /dev/null; then
        postCallVim
      fi
  fi
}
function postCallVim
{
  osascript -e 'tell application "MacVim" to activate'
}

alias v=callvim
alias vi=callvim
