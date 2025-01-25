# === Environment Variables ===
HISTSIZE=10000           # Number of commands to remember in the current session
SAVEHIST=10000           # Number of commands to save to history file
HISTFILE=~/.zsh_history  # Path to the history file

# export FUNCNEST=100

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$PATH:/home/mufeedcm/.local/bin" # Added by `pipx`
export EDITOR=nvim
export VISUAL=nvim

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(starship init zsh)"

# export PATH="$HOME/anaconda3/bin:$PATH"
# . "$HOME/anaconda3/etc/profile.d/conda.sh"

# Ensure Starship is always initialized, even inside tmux
if [[ -z "$TMUX" ]]; then
    eval "$(starship init zsh)"
fi
#
export STARSHIP_ZSH_KEYMAP_SELECT=0

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


zvm_vi_yank () {
	zvm_yank
	printf %s "${CUTBUFFER}" | xclip -sel c
	zvm_exit_visual_mode
}

alias cbread='xclip -selection c'
alias cbprint='xclip -o -selection clipboard'

my_zvm_vi_put_after() {
  CUTBUFFER=$(cbprint)
  zvm_vi_put_after
  zvm_highlight clear 
}

my_zvm_vi_put_before() {
  CUTBUFFER=$(cbprint)
  zvm_vi_put_before
  zvm_highlight clear
}

zvm_after_lazy_keybindings() {
  zvm_define_widget my_zvm_vi_put_after
  zvm_define_widget my_zvm_vi_put_before

  zvm_bindkey vicmd  'p' my_zvm_vi_put_after
  zvm_bindkey vicmd  'P' my_zvm_vi_put_before
}


# == auto ==
figlet mufeedcm

# === Aliases ===
# Common Aliases
alias la='ls -la'
alias cls='clear'
alias conf='cd ~/.config'
alias confnvim='nvim ~/.config/nvim/'

# Books
alias cbook1='zathura ~/books/programmingbooks/the-c-programming-language.pdf &'
alias cbook2='zathura ~/books/programmingbooks/c_programming_a_modern_approach_2e_c89_c99_king.pdf &'
alias ebook='zathura ~/books/electronicsbooks/art-of-electronics.pdf &'

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
