eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias la='ls -la'
alias conf='cd ~/.config'
alias confnvim='nvim ~/.config/nvim/'
alias cbook='zathura books/C\ Programming\ -\ A\ Modern\ Approach\ -\ 2nd_Ed\(C89,\ c99\)\ -\ King\ by\ .pdf&'
