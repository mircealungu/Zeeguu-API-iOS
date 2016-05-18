#!/bin/bash

# Generate Swift documentation

command -v jazzy >/dev/null 2>&1 || { echo "I require jazzy but it's not installed. Please install jazzy: https://github.com/realm/jazzy  Aborting..." >&2; exit 1; }

echo "Please enter the folder to save the docs in: "
read path

echo "Generating docs in '$path'..."

jazzy -x '-workspace,ZeeguuAPI.xcworkspace,-scheme,ZeeguuAPI' -a "Jorrit Oosterhof" -m "ZeeguuAPI" --readme "../README.md" --sdk "ios" --github_url "https://github.com/mircealungu/Zeeguu-Reader-iOS" --output "$path"

