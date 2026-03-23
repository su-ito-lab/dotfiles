#!/usr/bin/env bash
# ==================================================
# @file setup_zsh_plugins.sh
# @brief Install zsh plugins (not managed by git)
# ==================================================

set -euo pipefail

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
RESET="\033[0m"

PLUGIN_DIR="${HOME}/.zsh/plugins"

echo -e "${BLUE}[INFO]${RESET} Installing zsh plugins into ${PLUGIN_DIR}"

mkdir -p "${PLUGIN_DIR}"

clone_if_missing() {
	local repo="$1"
	local dir="$2"

	if [ -d "${dir}/.git" ]; then
	echo -e "${YELLOW}[SKIP]${RESET} ${dir} already exists"
	else
	echo -e "${GREEN}[CLONE]${RESET} ${repo} -> ${dir}"
	git clone --depth 1 "$repo" "$dir"
	fi
}

clone_if_missing https://github.com/zsh-users/zsh-autosuggestions \
  "${PLUGIN_DIR}/zsh-autosuggestions"

clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting \
  "${PLUGIN_DIR}/zsh-syntax-highlighting"

echo -e "${GREEN}[DONE]${RESET} zsh plugins setup complete"
