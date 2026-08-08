OS="$(uname)"

if [[ "$OS" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="$HOME/.local/bin:$PATH"

if [[ "$OS" == "Linux" ]]; then
  alias x='startx'

if [[ -z "$DISPLAY" ]] && [[ "${XDG_VTNR:-}" == "1" ]]; then
    # exec niri-session -l
    exec "$HOME/.local/bin/niri" --session
fi
fi


# Added by Antigravity CLI installer
export PATH="/home/mufeedcm/.local/bin:$PATH"
