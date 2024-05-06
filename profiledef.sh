#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="archlinux_gtnh"
iso_label="ARCH_GTNH_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" "+%Y%m%d_%H%M%S")"
iso_publisher="Arch Linux <https://archlinux.org>"
iso_application="Arch Linux (GTNH)"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" "+%Y-%m-%d_%H-%M-%S")"
install_dir="arch_gtnh"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.systemd-boot.esp' 'uefi-x64.systemd-boot.esp'
           'uefi-ia32.systemd-boot.eltorito' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=("-comp" "lz4" "-Xhc")
file_permissions=(
  ["/etc/gshadow"]="0:0:400"
  ["/etc/shadow"]="0:0:400"
)
