#!/bin/bash
# Set up this machine: Claude reads dotfiles/, installs what they depend on,
# then links them into $HOME. See .claude/skills/setup/SKILL.md.
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v claude >/dev/null; then
	echo "Claude Code is not installed. Install it with:" >&2
	echo "  curl -fsSL https://claude.ai/install.sh | bash" >&2
	exit 1
fi

exec claude "/setup $*"
