#!/bin/bash
set -e

# define directories
export ROOT="$PWD"
export SRCDEST="$PWD/tmp/src"
export PKGDEST="$PWD/tmp/pkg"

# create directories
mkdir -p "$SRCDEST"
mkdir -p "$PKGDEST"

# apply patches
for patchdir in packages/patches/*; do
  pkgname="$(basename $patchdir)"

  for patch in "$patchdir"/*.patch; do
    patchname=$(basename $patch)

    echo "Applying patch $patchname for $pkgname..."
    patch -d "packages/$pkgname" -Np1 < "$patch" || true
  done
done

# build packages
for pkgbuild in packages/*/PKGBUILD; do
  pushd "$(dirname $pkgbuild)"
    makepkg --force --noconfirm --skippgpcheck --syncdeps
  popd
done

# create repository
repo-add "$PKGDEST/custom.db.tar" "$PKGDEST"/*.pkg.tar.*
