HISTSIZE=10000           # Number of commands to remember in the current session
SAVEHIST=10000           # Number of commands to save to history file
HISTFILE=~/.zsh_history  # Path to the history file

export FUNCNEST=1000

tmux

clear
echo "mufeedcm"

# fastfetch


export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# eval "$(starship init zsh)"

setopt PROMPT_SUBST
custom_pwd() {
    if [[ $PWD == $HOME ]]; then
        echo "~"
    elif [[ $PWD == $HOME/* ]]; then
        echo "~${PWD/~}"
        # echo ${PWD/#$HOME/~}
    else
        echo $PWD
    fi
}
PROMPT='
%F{cyan}$(custom_pwd)%f
❯ '


source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.zsh/plugins/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# zvm_vi_yank () {
# 	zvm_yank
# 	printf %s "${CUTBUFFER}" | xclip -sel c
# 	zvm_exit_visual_mode
# }
#
# my_zvm_vi_put_after() {
#   CUTBUFFER=$(cbprint)
#   zvm_vi_put_after
#   zvm_highlight clear 
# }
#
# my_zvm_vi_put_before() {
#   CUTBUFFER=$(cbprint)
#   zvm_vi_put_before
#   zvm_highlight clear
# }
#
# zvm_after_lazy_keybindings() {
#   zvm_define_widget my_zvm_vi_put_after
#   zvm_define_widget my_zvm_vi_put_before
#
#   zvm_bindkey vicmd  'p' my_zvm_vi_put_after
#   zvm_bindkey vicmd  'P' my_zvm_vi_put_before
# }


# == auto ==
# figlet mufeedcm

alias la='ls -la'
alias cls='clear'
alias conf='cd ~/.config'
alias confnvim='nvim ~/.config/nvim/'

alias sourcezshrc='source ~/.zshrc'


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
