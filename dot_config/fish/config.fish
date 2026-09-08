# ~/.config/fish/config.fish

set fish_greeting

# block, line, underscore
set fish_cursor_default underscore

set -gx XDG_CURRENT_DESKTOP dwl
set -gx XDG_SESSION_DESKTOP dwl
set -gx XDG_SESSION_TYPE wayland
set -gx MOZ_ENABLE_WAYLAND 1
set -gx QT_QPA_PLATFORM wayland
set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -gx GDK_BACKEND wayland
set -gx CLUTTER_BACKEND wayland

set -gx PATH /home/kaon/.cargo/bin $PATH
set -gx PATH /home/kaon/.local/bin $PATH

# fzf
set -gx FZF_DEFAULT_OPTS " \
  --color=fg:#c1c1c1,bg:#000000,hl:#79241f \
  --color=fg+:#c1c1c1,bg+:#121212,hl+:#f8f7f2 \
  --color=info:#999999,prompt:#79241f,pointer:#79241f \
  --color=marker:#f8f7f2,spinner:#79241f,header:#999999 \
  --color=border:#000000,separator:#333333 \
  --no-border --padding=0 --margin=0 \
  --separator='' --scrollbar='' \
  --no-info --prompt=' '"

# zoxide
zoxide init --cmd j fish | source

# alias
alias yay=paru
abbr --add ls "eza -a"
abbr --add copy wl-copy
abbr --add find fd
abbr --add cat bat
abbr --add hx helix
abbr --add jj ji
alias vi=nvim
abbr --add cat bat
abbr --add grep rg
abbr --add aria aria2c

abbr --add cmb "cmake -S . -B build && cmake --build build"

abbr --add ta "tmux attach"
abbr --add tl "tmux list-sessions"
abbr --add tn "tmux new-session -s"

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# disable mode indicator so elegant
function fish_mode_prompt
end
