#!/usr/bin/env bash
# ==================================================
# @file scripts/bootstrap.sh
# @brief Bootstrap script for dotfiles
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
REPO_URL="https://github.com/su-ito-lab/dotfiles.git"

info "Starting bootstrap process..."

# --------------------------------------------------
# Install Miniconda
# --------------------------------------------------
if [[ -d "${MINICONDA_DIR}" ]]; then
	pass "Miniconda is already installed at ${MINICONDA_DIR}"
else
	info "Installing Miniconda..."
	curl -fLO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash Miniconda3-latest-Linux-x86_64.sh -b -p "${MINICONDA_DIR}"
	rm -f Miniconda3-latest-Linux-x86_64.sh
	pass "Miniconda installed successfully at ${MINICONDA_DIR}"
fi

# --------------------------------------------------
# Create CLI conda environment
# --------------------------------------------------
if "${MINICONDA_DIR}/condabin/conda" env list | grep -q "^cli[[:space:]]"; then
	pass "CLI conda environment already exists"
else
	info "Creating CLI conda environment..."
	"${MINICONDA_DIR}/condabin/conda" create -n cli -c conda-forge git -y
	pass "CLI conda environment created successfully"
fi

# --------------------------------------------------
# Clone dotfiles repository
# --------------------------------------------------
if [[ -d "${DOTFILES_DIR}/.git" ]]; then
	info "Dotfiles repository already exists. Pulling latest changes..."
	"${MINICONDA_DIR}/envs/cli/bin/git" -C "${DOTFILES_DIR}" pull --ff-only
	pass "Dotfiles repository updated successfully"
else
	info "Cloning dotfiles repository..."
	mkdir -p "$(dirname "${DOTFILES_DIR}")"
	"${MINICONDA_DIR}/envs/cli/bin/git" clone "${REPO_URL}" "${DOTFILES_DIR}"
	pass "Dotfiles repository cloned successfully to ${DOTFILES_DIR}"
fi

# --------------------------------------------------
# Run setup script
# --------------------------------------------------
if [[ -f "${DOTFILES_DIR}/scripts/setup.sh" ]]; then
	info "Running setup script..."
	bash "${DOTFILES_DIR}/scripts/setup.sh"
	pass "Bootstrap process completed successfully"
else
	warn "Setup script not found at ${DOTFILES_DIR}/scripts/setup.sh. Skipping..."
	warn "Bootstrap process completed with warnings"
fi
