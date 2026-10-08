#!/bin/bash
set -e

echo "=== Setting up Flutter SDK ==="
if [ ! -d "_flutter" ]; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable _flutter
fi

export PATH="$PATH:$(pwd)/_flutter/bin"

echo "=== Verifying Flutter Installation ==="
flutter --version

echo "=== Building Flutter Web Application ==="
flutter config --enable-web
flutter build web --release

echo "=== Build Finished Successfully ==="
