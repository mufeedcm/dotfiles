# === Environment Variables ===
HISTSIZE=10000           # Number of commands to remember in the current session
SAVEHIST=10000           # Number of commands to save to history file
HISTFILE=~/.zsh_history  # Path to the history file

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$PATH:/home/mufeedcm/.local/bin" # Added by `pipx`

# === Starship Prompt (Initialize if in tmux) ===
eval "$(starship init zsh)"
if [[ -z "$TMUX" ]]; then
    eval "$(starship init zsh)"
fi

# === NVM Setup ===
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# == auto ==
figlet mufeedcm
buckle &

# === Aliases ===
# Common Aliases
alias la='ls -la'
alias cls='clear'
alias conf='cd ~/.config'
alias confnvim='nvim ~/.config/nvim/'

# Books
alias cbook1='zathura ~/books/the-c-programming-language.pdf &'
alias cbook2='zathura ~/books/c_programming_a_modern_approach_2e_c89_c99_king.pdf &'

# Quran Player
alias todo='nvim ~/notes/3.Main_notes/Todo.md'

alias sourcezshrc='source ~/.zshrc'
alias azantimes="~/azantimes/azantime.sh"

# === Functions ===
# Quran Player
quran() {
  volume=${1:-50}  # Default volume if not provided
  mpv --volume=$volume ~/Music/surah_muhammed.m4a
}

pushnotes() {
    local prev_dir=$(pwd)
    echo "Pushing Notes..."
    cd ~/notes || return
    git add .
    git commit -m "auto"
    git push -u origin main
    cd "$prev_dir"
}

pushdots() {
    local prev_dir=$(pwd)
    echo "Pushing Dotfiles..."
    cd ~/dotfiles || return
    git add .
    git commit -m "auto"
    git push -u origin main
    cd "$prev_dir"
}

pushall() {
    echo "Pushing Notes & Dotfiles..."
    pushnotes
    echo "------------------------"
    pushdots
}

pullnotes() {
    local prev_dir=$(pwd)
    echo "Pulling Notes..."
    cd ~/notes || return
    git pull origin main
    cd "$prev_dir"
}

pulldots() {
    local prev_dir=$(pwd)
    echo "Pulling Dotfiles..."
    cd ~/dotfiles || return
    git pull origin main
    cd "$prev_dir"
}

pullall() {
    echo "Pulling Notes & Dotfiles..."
    pullnotes
    echo "------------------------"
    pulldots
}

checknotes() {
    local prev_dir=$(pwd)
    echo "Checking Notes Repo Status..."
    cd ~/notes || return
    git status
    cd "$prev_dir"
}

checkdots() {
    local prev_dir=$(pwd)
    echo "Checking Dotfiles Repo Status..."
    cd ~/dotfiles || return
    git status
    cd "$prev_dir"
}

checkall() {
    echo "Checking Status of Notes & Dotfiles..."
    checknotes
    echo "------------------------"
    checkdots
}
