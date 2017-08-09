#!/usr/bin/env bash

set -e

vendor_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

release_url="$(curl -s https://api.github.com/repos/binoculars/ffmpeg-build-lambda/releases/latest | jq -r '.assets[0].browser_download_url')"

mkdir -p "$vendor_dir/tmp"
curl -sSL -o - "$release_url" | tar xzf - -C "$vendor_dir/tmp"

mv "$(find "$vendor_dir/tmp" -name ffmpeg -type f)" "$vendor_dir/ffmpeg"
rm -rf "$vendor_dir/tmp"

gzip -f "$vendor_dir/ffmpeg"
