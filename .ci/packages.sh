#!/bin/bash
set -e

# define directories
export ROOT="$PWD"
export SRCDEST="$PWD/tmp/src"
export PKGDEST="$PWD/tmp/pkg"

# create directories
mkdir -p "$SRCDEST"
mkdir -p "$PKGDEST"

# check if there any packages
if [ -z "$(ls -A packages/)" ]; then
  exit 0
fi

# build packages
for pkgbuild in packages/*/PKGBUILD; do
  pushd "$(dirname $pkgbuild)"
    makepkg --force --noconfirm --skippgpcheck --syncdeps
  popd
done

# create repository
repo-add "$PKGDEST/custom.db.tar" "$PKGDEST"/*.pkg.tar.*
