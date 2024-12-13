
HISTSIZE=10000           # Number of commands to remember in the current session
SAVEHIST=10000           # Number of commands to save to history file
HISTFILE=~/.zsh_history  # Path to the history file


# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
#

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# if ! grep -q "source ~/.zsh/autosuggestions/zsh-autosuggestions.zsh" ~/.zshrc; then
    # echo "source ~/.zsh/autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
# fi

source ~/.zsh/autosuggestions/zsh-autosuggestions.zsh
alias la='ls -la'
alias conf='cd ~/.config'
alias confnvim='nvim ~/.config/nvim/'

# alias cbook='zathura ~/books/c_programming_a_modern_approach_2e_c89_c99_king.pdf &'


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
