# ==================================================
# @file .zshrc
# @brief Zsh settings
# ==================================================

# --------------------------------------------------
# locale
# --------------------------------------------------
export LANG='C.UTF-8'
export LC_CTYPE='C.UTF-8'
unset LC_ALL

# --------------------------------------------------
# paths
# --------------------------------------------------
export LOCAL_BIN="$HOME/.local/bin"
export MINICONDA_PREFIX="$HOME/miniconda3"
export CLI_PREFIX="$MINICONDA_PREFIX/envs/cli"
export PY312_PREFIX="$MINICONDA_PREFIX/envs/py312"

typeset -U path PATH
[[ -d "$HOME/.cargo/bin" ]] && path=("$HOME/.cargo/bin" $path)
[[ -d "$MINICONDA_PREFIX/condabin" ]] && path=("$MINICONDA_PREFIX/condabin" $path)
[[ -d "$CLI_PREFIX/bin" ]] && path=("$CLI_PREFIX/bin" $path)
[[ -d "$LOCAL_BIN" ]] && path=("$LOCAL_BIN" $path)
export PATH

# --------------------------------------------------
# aliases
# --------------------------------------------------

# safer operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# ls
alias ls='ls -F --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep
alias grep='grep --color=auto'

# vim
alias vi='vim'
alias view='vim -R'

# disk
alias df='df -h'
alias du='du -h'
alias free='free -h'

# CAD aliases migrated from csh
alias vhdlan='vhdlan -full64'
alias vlogan='vlogan -full64'
alias vcs='vcs -full64'
alias dve='dve -mode64'
alias icc_shell='icc_shell -shared_license'

# python
alias python312="$PY312_PREFIX/bin/python"
alias pip312="$PY312_PREFIX/bin/python -m pip"

# --------------------------------------------------
# history
# --------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

# --------------------------------------------------
# shell behavior
# --------------------------------------------------
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt EXTENDED_GLOB

# --------------------------------------------------
# less / pager
# --------------------------------------------------
export LESS='-R -F -X'
export PAGER='less'

if [[ -x /usr/bin/lesspipe ]]; then
	eval "$(SHELL=/bin/sh lesspipe)"
fi

# --------------------------------------------------
# dircolors
# --------------------------------------------------
if command -v dircolors >/dev/null 2>&1; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# --------------------------------------------------
# completion
# --------------------------------------------------
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --------------------------------------------------
# plugins
# --------------------------------------------------

# fzf
if [[ -f "$CLI_PREFIX/share/fzf/key-bindings.zsh" ]]; then
	source "$CLI_PREFIX/share/fzf/key-bindings.zsh"
fi

if [[ -f "$CLI_PREFIX/share/fzf/completion.zsh" ]]; then
	source "$CLI_PREFIX/share/fzf/completion.zsh"
fi

# zsh-autosuggestions
if [[ -f "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
	source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# oh-my-posh
if command -v oh-my-posh >/dev/null 2>&1 && [[ -f "$HOME/.config/oh-my-posh/themes/dark-dimmed.omp.json" ]]; then
	eval "$(oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/themes/dark-dimmed.omp.json")"
fi

# zsh-syntax-highlighting
if [[ -f "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
	source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
