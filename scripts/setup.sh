#!/usr/bin/env bash
# ==================================================
# @file scripts/setup.sh
# @brief Setup script for dotfiles
# ==================================================

set -euo pipefail

readonly COLOR_RESET='\033[0m'
readonly COLOR_RED='\033[31m'
readonly COLOR_GREEN='\033[32m'
readonly COLOR_YELLOW='\033[33m'
readonly COLOR_BLUE='\033[34m'

info() { printf "${COLOR_BLUE}[INFO]${COLOR_RESET} %s\n" "$*"; }
pass() { printf "${COLOR_GREEN}[PASS]${COLOR_RESET} %s\n" "$*"; }
warn() { printf "${COLOR_YELLOW}[WARN]${COLOR_RESET} %s\n" "$*"; }
fail() { printf "${COLOR_RED}[ERROR]${COLOR_RESET} %s\n" "$*" >&2; }

MINICONDA_DIR="${HOME}/miniconda3"
DOTFILES_DIR="${HOME}/src/github.com/su-ito-lab/dotfiles"

CONDA="${MINICONDA_DIR}/condabin/conda"
GIT="${MINICONDA_DIR}/envs/cli/bin/git"
STOW="${MINICONDA_DIR}/envs/cli/bin/stow"

info "Starting setup process..."

cd "${DOTFILES_DIR}"

# --------------------------------------------------
# Update conda environments
# --------------------------------------------------
info "Updating CLI conda environment..."
"${CONDA}" env update -n cli -f env/cli.yml
pass "CLI conda environment updated successfully"

if "${CONDA}" env list | grep -q "^py312[[:space:]]"; then
	info "Updating py312 conda environment..."
	"${CONDA}" env update -n py312 -f env/py312.yml
	pass "py312 conda environment updated successfully"
else
	info "Creating py312 conda environment..."
	"${CONDA}" env create -f env/py312.yml
	pass "py312 conda environment created successfully"
fi

# --------------------------------------------------
# Install oh-my-posh
# --------------------------------------------------
if [[ -x "${HOME}/.local/bin/oh-my-posh" ]]; then
	pass "oh-my-posh is already installed"
else
	info "Installing oh-my-posh..."
	mkdir -p "${HOME}/.local/bin"
	curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "${HOME}/.local/bin"
	pass "oh-my-posh installed successfully"
fi

# --------------------------------------------------
# Install fzf
# --------------------------------------------------
if [[ -x "${HOME}/.fzf/bin/fzf" ]]; then
	pass "fzf is already installed"
else
	info "Installing fzf..."
	"${GIT}" clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
	"${HOME}/.fzf/install" --key-bindings --completion --no-update-rc
	pass "fzf installed successfully"
fi

# --------------------------------------------------
# Install zsh plugins
# --------------------------------------------------
mkdir -p "${HOME}/.zsh/plugins"
if [[ -d "${HOME}/.zsh/plugins/zsh-autosuggestions/.git" ]]; then
	info "Updating zsh-autosuggestions plugin..."
	"${GIT}" -C "${HOME}/.zsh/plugins/zsh-autosuggestions" pull --ff-only
	pass "zsh-autosuggestions plugin updated successfully"
else
	info "Installing zsh-autosuggestions plugin..."
	"${GIT}" clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git "${HOME}/.zsh/plugins/zsh-autosuggestions"
	pass "zsh-autosuggestions plugin installed successfully"
fi
if [[ -d "${HOME}/.zsh/plugins/zsh-syntax-highlighting/.git" ]]; then
	info "Updating zsh-syntax-highlighting plugin..."
	"${GIT}" -C "${HOME}/.zsh/plugins/zsh-syntax-highlighting" pull --ff-only
	pass "zsh-syntax-highlighting plugin updated successfully"
else
	info "Installing zsh-syntax-highlighting plugin..."
	"${GIT}" clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}/.zsh/plugins/zsh-syntax-highlighting"
	pass "zsh-syntax-highlighting plugin installed successfully"
fi

# --------------------------------------------------
# Install Rust and tree-sitter
# --------------------------------------------------
if command -v cargo >/dev/null 2>&1; then
	pass "Rust is already installed"
else
	info "Installing Rust..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	pass "Rust installed successfully"
fi
export PATH="${HOME}/.cargo/bin:${PATH}"
if [[ -x "${HOME}/.cargo/bin/tree-sitter" ]]; then
	pass "tree-sitter is already installed"
else
	info "Installing tree-sitter..."
	"${HOME}/.cargo/bin/cargo" install tree-sitter-cli
	pass "tree-sitter installed successfully"
fi

# --------------------------------------------------
# Stow dotfiles
# --------------------------------------------------
info "Stowing dotfiles..."
"${STOW}" -vt "${HOME}" \
	csh \
	zsh \
	git \
	gh \
	lazygit \
	vim \
	nvim \
	oh-my-posh \
	conda
pass "Dotfiles stowed successfully"

# --------------------------------------------------
# Create ~/.gitconfig.local
# --------------------------------------------------
if [[ -f "${HOME}/.gitconfig.local" ]]; then
	info "~/.gitconfig.local already exists. Skipping creation."
else
	info "Creating ~/.gitconfig.local..."
	read -r -p "Enter your name for git commits: " git_name
	read -r -p "Enter your email for git commits: " git_email
	cat >"${HOME}/.gitconfig.local" <<EOF
[user]
	name = ${git_name}
	email = ${git_email}
EOF
	pass "~/.gitconfig.local created successfully"
fi

# --------------------------------------------------
# Final message
# --------------------------------------------------
pass "Setup process completed successfully"
