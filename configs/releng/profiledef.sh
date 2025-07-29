#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="gamerx-linux"
iso_label="GAMERX_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="GamerX Linux <https://gamerxlinux.org>"
iso_application="GamerX Linux Live/Install ISO"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="gamerx"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="erofs"
airootfs_image_tool_options=('-zlzma,109' -E 'ztailpacking')
bootstrap_tarball_compression=(zstd -c -T0 --long -19)
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/usr/local/bin/gxinstall"]="0:0:755"
  ["/usr/local/bin/gx_disk.py"]="0:0:755"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/lib/gxinstall/profiles/gamerx-hyprland.py"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/Installer/install_hyprland.sh"]="0:0:755"
  ["/usr/local/bin/Installer/install_gaming.sh"]="0:0:755"
  ["/usr/local/bin/Installer/install_hacking.sh"]="0:0:755"
  ["/usr/local/bin/profiles/Hyprland/install.sh"]="0:0:755"
  ["/usr/local/bin/profiles/Gaming/install.sh"]="0:0:755"
  ["/usr/local/bin/profiles/Hacking/install.sh"]="0:0:755"
  ["/usr/local/bin/gx_collect_logs.sh"]="0:0:755"
  ["/usr/local/bin/LICENSE"]="0:0:755"
  ["/usr/local/bin/README.md"]="0:0:755"
  ["/usr/local/bin/profiles/Hyprland/verify_paths.sh"]="0:0:755"
  ["/usr/local/bin/utils/path_checker.sh"]="0:0:755"
  ["/usr/local/bin/gxupdate_helper.py"]="0:0:755"
)

