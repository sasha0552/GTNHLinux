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
pacman --sync --noconfirm --needed base-devel git patch python python-jinja sudo

# Install required packages
if [ "$ARCH" = "x86_64" ]; then
  pacman --sync --noconfirm --needed archiso reflector
elif [ "$ARCH" = "aarch64" ]; then
  pacman --sync --noconfirm --needed arch-install-scripts bash dosfstools e2fsprogs erofs-utils grub libarchive libisoburn mtools squashfs-tools
fi

# Configure mirrorlist
if [ "$ARCH" = "x86_64" ]; then
  reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
fi

# Configure archiso
if [ "$ARCH" = "aarch64" ]; then
  # Clone repository
  git clone https://github.com/JackMyers001/archiso-aarch64.git /tmp/archiso-aarch64

  # Create symlink for mkarchiso
  ln -s /tmp/archiso-aarch64/archiso/mkarchiso /usr/local/bin/mkarchiso
fi

# Create user
useradd user

# Grant sudo access to user
echo "user ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

# Change owner/group of current directory to user
chown -R user:user .
