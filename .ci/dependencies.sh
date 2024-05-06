#!/bin/sh
set -eu

# Refresh package databases
pacman --sync --noconfirm --refresh

# Upgrade system
pacman --sync --noconfirm --sysupgrade

# Remove existing keys
rm -fr /etc/pacman.d/gnupg

# Init keystore
pacman-key --init

# Populate keystore
pacman-key --populate

# Install required packages
pacman --sync --noconfirm --needed archiso base-devel patch reflector sudo

# Configure mirrorlist
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Create user
useradd user

# Grant sudo access to user
echo "user ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

# Change owner/group of current directory to user
chown -R user:user .
