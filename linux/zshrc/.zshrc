
HISTSIZE=10000           # Number of commands to remember in the current session
SAVEHIST=10000           # Number of commands to save to history file
HISTFILE=~/.zsh_history  # Path to the history file


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"

# Ensure Starship is always initialized, even inside tmux
if [[ -z "$TMUX" ]]; then
    eval "$(starship init zsh)"
fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source ~/.zsh/autosuggestions/zsh-autosuggestions.zsh

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
alias todo='nvim ~/notes/3.Main_notes/Todo.md'

# === push notes ===
pushnotes() {
    local prev_dir=$(pwd)
    echo
    echo "======================================="
    echo "         PUSHING NOTES REPO"
    echo "======================================="
    echo
    echo ">>> Switching to ~/notes"
    cd ~/notes || return
    echo ">>> Adding changes to the staging area..."
    git add .
    echo ">>> Committing changes..."
    git commit -m "note add"
    echo ">>> Pushing changes to the remote repository..."
    git push -u origin main
    echo
    echo "=== Notes repository pushed successfully! ==="
    echo
    cd "$prev_dir"
}

pushdots() {
    local prev_dir=$(pwd)
    echo
    echo "======================================="
    echo "         PUSHING DOTFILES REPO"
    echo "======================================="
    echo
    echo ">>> Switching to ~/dotfiles"
    cd ~/dotfiles || return
    echo ">>> Adding changes to the staging area..."
    git add .
    echo ">>> Committing changes..."
    git commit -m "add:"
    echo ">>> Pushing changes to the remote repository..."
    git push -u origin main
    echo
    echo "=== Dotfiles repository pushed successfully! ==="
    echo
    cd "$prev_dir"
}

pushall() {
    echo
    echo "======================================="
    echo "    STARTING PUSHING NOTES & DOTFILES"
    echo "======================================="
    echo
    pushnotes
    echo "---------------------------------------"
    pushdots
    echo "---------------------------------------"
    echo
    echo "======================================="
    echo "  ALL REPOSITORIES PUSHED SUCCESSFULLY!"
    echo "======================================="
    echo
}
# === pull notes ===
pullnotes() {
    local prev_dir=$(pwd)
    echo
    echo "======================================="
    echo "         PULLING NOTES REPO"
    echo "======================================="
    echo
    echo ">>> Switching to ~/notes"
    cd ~/notes || return
    echo ">>> Pulling changes from the remote repository..."
    git pull origin main
    echo
    echo "=== Notes repository updated successfully! ==="
    echo
    cd "$prev_dir"
}

pulldots() {
    local prev_dir=$(pwd)
    echo
    echo "======================================="
    echo "         PULLING DOTFILES REPO"
    echo "======================================="
    echo
    echo ">>> Switching to ~/dotfiles"
    cd ~/dotfiles || return
    echo ">>> Pulling changes from the remote repository..."
    git pull origin main
    echo
    echo "=== Dotfiles repository updated successfully! ==="
    echo
    cd "$prev_dir"
}

pullall() {
    echo
    echo "======================================="
    echo "    STARTING PULLING NOTES & DOTFILES"
    echo "======================================="
    echo
    pullnotes
    echo "---------------------------------------"
    pulldots
    echo "---------------------------------------"
    echo
    echo "======================================="
    echo "  ALL REPOSITORIES UPDATED SUCCESSFULLY!"
    echo "======================================="
    echo
}

# === check status of notes ===
checknotes() {
    local prev_dir=$(pwd)
    echo
    echo "======================================="
    echo "       CHECKING NOTES REPO STATUS"
    echo "======================================="
    echo
    echo ">>> Switching to ~/notes"
    cd ~/notes || return
    echo ">>> Checking status of the repository..."
    git status
    echo
    echo "=== Notes repository status checked! ==="
    echo
    cd "$prev_dir"
}

checkdots() {
    local prev_dir=$(pwd)
    echo
    echo "======================================="
    echo "       CHECKING DOTFILES REPO STATUS"
    echo "======================================="
    echo
    echo ">>> Switching to ~/dotfiles"
    cd ~/dotfiles || return
    echo ">>> Checking status of the repository..."
    git status
    echo
    echo "=== Dotfiles repository status checked! ==="
    echo
    cd "$prev_dir"
}

checkall() {
    echo
    echo "======================================="
    echo " CHECKING STATUS OF NOTES & DOTFILES"
    echo "======================================="
    echo
    checknotes
    echo "---------------------------------------"
    checkdots
    echo "---------------------------------------"
    echo
    echo "======================================="
    echo "  STATUS OF ALL REPOSITORIES CHECKED!"
    echo "======================================="
    echo
}



# Created by `pipx` on 2024-12-31 03:55:36
export PATH="$PATH:/home/mufeedcm/.local/bin"
