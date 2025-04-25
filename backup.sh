#!/usr/bin/env bash

set -euxo pipefail

FX_PASSWORD="uw4xfPqE96*rfd"

ARCHIVE_PATH="all.tar.xz"

curl --proto '=https' --tlsv1.2 -sSf \
  -H "Authorization: Bearer $FX_PASSWORD" \
  https://fx.huijzer.xyz/api/download/all.tar.xz > "$ARCHIVE_PATH"

tar --verbose -xf "$ARCHIVE_PATH"
