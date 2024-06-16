#!/bin/sh
echo -ne '\033c\033]0;Pyramid Survivor\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Pyramid Survivor.x86_64" "$@"
