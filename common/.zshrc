if [[ -z "$TMUX" ]]; then
    if uwsm check may-start &>/dev/null && uwsm select; then
        exec uwsm start default
    fi
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -Uz compinit
compinit

tmux_sessionaizer() {
    zle -I
    BUFFER="tmux.sessionaizer"
    zle accept-line
}
zle -N tmux_sessionaizer

tmux_main() {
    zle -I
    BUFFER="tmux.sessionaizer main"
    zle accept-line
}
zle -N tmux_main

bindkey -e
bindkey "^[;" tmux_sessionaizer
bindkey "^['" tmux_main

if command -v trash-put &>/dev/null; then
    alias rm='trash-put -v'
fi
if command -v eza &>/dev/null; then
    alias ls="eza --icons=auto"
fi
if command -v bat &>/dev/null; then
    alias cat="bat --color always --plain --theme=Catppuccin_Mocha"
fi
if command -v batcat &>/dev/null; then
    alias cat="batcat --color always --plain --theme=Catppuccin_Mocha"
fi
if command -v fdfind &>/dev/null; then
    alias fd="fdfind"
fi
alias ..='cd ..'
alias grep='grep --color=auto'
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"

ZINIT_HOME="${ZINIT_HOME:-${XDG_DATA_HOME:-${HOME}/.local/share}/zinit}"

if [[ ! -f ${ZINIT_HOME}/zinit.git/zinit.zsh ]]; then
    print -P "%F{14}▓▒░ Installing Flexible and fast ZSH plugin manager %F{13}(zinit)%f"
    command mkdir -p "${ZINIT_HOME}" && command chmod g-rwX "${ZINIT_HOME}"
    command git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}/zinit.git" &&
        print -P "%F{10}▓▒░ Installation successful.%f%b" ||
        print -P "%F{9}▓▒░ The clone has failed.%f%b"
fi

source "${ZINIT_HOME}/zinit.git/zinit.zsh"

zinit light-mode for \
    Aloxaf/fzf-tab \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    blockf \
    zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit ice as'command' from'gh-r' \
    atload'export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml; eval $(starship init zsh)' \
    atclone'./starship init zsh > init.zsh; ./starship completions zsh > _starship' \
    atpull'%atclone' src'init.zsh'
zinit light starship/starship

zstyle ':fzf-tab:*' fzf-flags --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --prompt '󰭎 ' --pointer ' λ' --layout=reverse --border top \
    --multi

export FZF_DEFAULT_OPTS="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--prompt '󰭎 ' --pointer '' --layout=reverse --border top \
--multi"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.local/share/flatpak/exports/bin:$PATH"

for dir in $HOME/.scripts/**/; do
    PATH="$dir:$PATH"
done

# BEGIN nodejs
export NPM_CONFIG_CACHE=$HOME/.node
export NPM_CONFIG_PREFIX=$HOME/.node
if command -v fnm &>/dev/null; then
   eval "$(fnm env --shell zsh)"
fi
export FNM_DIR=$HOME/.node
# END nodejs

# BEGIN php
export PATH="$HOME/.php/bin:$PATH"
export COMPOSER_HOME="$HOME/.php"
export PHP_CS_FIXER_IGNORE_ENV=true
# END php

# BEGIN go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/versions/go1.24.1/bin"
export PATH="$PATH:$GOPATH/bin"
# END go

# BEGIN rust
export RUSTUP_HOME="$HOME/.cache/rustup"
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"
# END rust
