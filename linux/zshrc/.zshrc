
HISTSIZE=10000           # Number of commands to remember in the current session
SAVEHIST=10000           # Number of commands to save to history file
HISTFILE=~/.zsh_history  # Path to the history file


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
alias cls='clear'
alias conf='cd ~/.config'
alias confnvim='nvim ~/.config/nvim/'

alias cbook='zathura ~/books/c_programming_a_modern_approach_2e_c89_c99_king.pdf &'
quran() {
  if [ -z "$1" ]; then
    volume=50 # Default volume if none is provided
  else
    volume=$1
  fi
  mpv --volume=$volume ~/Music/surah_muhammed.m4a
}



pushnotes() {
    local prev_dir=$(pwd)
    echo
    echo "=== Pushing Notes ==="
    echo
    echo "Switching to ~/notes..."
    cd ~/notes || return
    echo "Adding changes to staging area..."
    git add .
    echo "Committing changes..."
    git commit -m "note add"
    echo "Pushing to remote repository..."
    git push -u origin main
    echo
    echo "Finished pushing notes."
    echo
    cd "$prev_dir"
}

pushdots() {
    local prev_dir=$(pwd)
    echo
    echo "=== Pushing Dotfiles ==="
    echo
    echo "Switching to ~/dotfiles..."
    cd ~/dotfiles || return
    echo "Adding changes to staging area..."
    git add .
    echo "Committing changes..."
    git commit -m "add:"
    echo "Pushing to remote repository..."
    git push -u origin main
    echo
    echo "Finished pushing dotfiles."
    echo
    cd "$prev_dir"
}

pushall() {
    echo
    echo "=== Starting Push for All Repositories ==="
    echo
    pushnotes
    echo "-----------------------------"
    pushdots
    echo "-----------------------------"
    echo
    echo "All repositories have been pushed successfully."
    echo
}

