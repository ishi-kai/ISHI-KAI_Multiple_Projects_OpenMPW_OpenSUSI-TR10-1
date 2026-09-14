#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
macro_source="$script_dir/pymacros/path_start_preview.lym"
macro_dir="${KLAYOUT_HOME:-$HOME/.klayout}/pymacros"
macro_target="$macro_dir/path_start_preview.lym"

mkdir -p -- "$macro_dir"

if [[ -e "$macro_target" && ! -L "$macro_target" ]]; then
    echo "Refusing to replace non-symlink: $macro_target" >&2
    exit 1
fi

ln -sfn -- "$macro_source" "$macro_target"
echo "Installed $macro_target -> $macro_source"
echo "Restart KLayout to load Path start preview."
