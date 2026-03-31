OS="$(uname)"

if [[ "$OS" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="$HOME/.local/bin:$PATH"

if [[ "$OS" == "Linux" ]]; then
  alias x='startx'

  if [[ -z "$DISPLAY" ]] && [[ "$(tty)" == "/dev/tty1" ]]; then
    [[ -x "$(command -v start-hyprland)" ]] && exec start-hyprland
  fi
fi
