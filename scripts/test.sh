#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROCKS_TREE="$ROOT_DIR/.tests/rocks"
LUAJIT_BIN="$(command -v luajit)"
LUAJIT_DIR="$(cd "$(dirname "$(realpath "$LUAJIT_BIN")")/.." && pwd)"

mkdir -p "$ROCKS_TREE"

if [ ! -x "$ROCKS_TREE/bin/busted" ]; then
	luarocks \
		--lua-version=5.1 \
		--tree="$ROCKS_TREE" \
		--lua-dir="$LUAJIT_DIR" \
		install busted
fi

if [ "$#" -eq 0 ]; then
	set -- tests
fi

cd "$ROOT_DIR"
nvim -l tests/busted.lua "$@"
