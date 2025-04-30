#!/usr/bin/env bash

set -euxo pipefail

ARCHIVE_PATH="all.tar.xz"

download() {
  curl --proto "=https" --tlsv1.2 -sSf \
    -H "Authorization: Bearer $FX_PASSWORD" \
    https://fx.huijzer.xyz/api/download/all.tar.xz > "$ARCHIVE_PATH"

  tar --verbose -xf "$ARCHIVE_PATH"
  rm "$ARCHIVE_PATH"
}

commit() {
  if [ -n "$(git status --porcelain)" ]; then
    git config --global user.email "$GITHUB_ACTOR@users.noreply.github.com"
    git config --global user.name "$GITHUB_ACTOR"

    git add .
    git commit -m '[bot] backup'
    git push
  fi
}

if [[ "$1" == "download" ]]; then
  echo "Running download..."
  download
elif [[ "$1" == "commit" ]]; then
  echo "Running commit..."
  commit
fi
