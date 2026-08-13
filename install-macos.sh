#!/usr/bin/env bash

set -euo pipefail

readonly TAP="toandev95/apps"
readonly CASK="thuyha"
readonly APP_PATH="/Applications/thuyha.me.app"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This installer only supports macOS."
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it from https://brew.sh, then run this installer again."
  exit 1
fi

brew tap "$TAP"
brew trust --tap "$TAP"
brew uninstall --cask "$CASK" --force >/dev/null 2>&1 || true
brew install --cask "$CASK" --force

if [[ ! -d "$APP_PATH" ]]; then
  echo "The app was not found at $APP_PATH after installation."
  exit 1
fi

xattr -dr com.apple.quarantine "$APP_PATH"
open "$APP_PATH"
