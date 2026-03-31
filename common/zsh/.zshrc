OS="$(uname)"

# === Environment Variables ===
HISTSIZE=10000           # Number of commands to remember in the current session
SAVEHIST=10000           # Number of commands to save to history file
HISTFILE=~/.zsh_history  # Path to the history file

export FUNCNEST=1000
export XDG_CONFIG_HOME="$HOME/.config"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim
export RANGER_LOAD_DEFAULT_RC=false
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'

if [[ "$OS" == "Linux" ]]; then
  export GTK_MODULES=gail:atk-bridge
  export AT_SPI_BUS=at-spi-bus-launcher

  source ~/emsdk/emsdk_env.sh
  export JAVA_HOME=/opt/android-studio/jbr
  export ANDROID_HOME=$HOME/Android/Sdk
  export PATH=$ANDROID_HOME/platform-tools:$PATH
fi


# for wezterm
setopt COMBINING_CHARS
bindkey -M vicmd "^C"    undefined-key
bindkey -M vicmd "^[[1;6C" undefined-key


export NVM_DIR="$HOME/.nvm"
if [[ "$OS" == "Linux" ]]; then
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
elif [[ "$OS" == "Darwin" ]]; then
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \
    . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi


#tmux 
if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
  tmux new -s "auto_$PPID"
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


# opencode
export PATH="$HOME/.opencode/bin:$PATH"


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

source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/plugins/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ "$OS" == "Darwin" ]]; then
  alias cbprint='pbpaste'
elif [[ "$OS" == "Linux" ]]; then
  alias cbprint='xclip -o -selection clipboard'
fi

zvm_vi_yank () {
  zvm_yank
  if [[ "$OS" == "Darwin" ]]; then
    printf %s "${CUTBUFFER}" | pbcopy
  elif [[ "$OS" == "Linux" ]]; then
    printf %s "${CUTBUFFER}" | xclip -sel c
  fi
  zvm_exit_visual_mode
}


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


jumptofolder() {
  cd "$(find -L ~ -type d -maxdepth 5 2>/dev/null \
    | fzf --prompt='open > ' --height=40% --reverse)" 2>/dev/null
  }

# === Aliases ===
alias ls='ls --color=auto'
alias la='ls -lahr --color=auto'
alias jp='jumptofolder'
alias grep='grep --color=auto'
alias cls='clear'
alias conf='cd $HOME/.config'
alias confnvim='nvim $HOME/.config/nvim/'

alias sourcezshrc='source $HOME/.zshrc'
