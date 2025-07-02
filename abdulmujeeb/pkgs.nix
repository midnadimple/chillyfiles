{ pkgs }:

with pkgs; [
  desktop-file-utils
  winetricks
  gst_all_1.gstreamer
  gst_all_1.gst-plugins-base

  discord
  just

  anki
  blender
  aseprite
  goxel
  
  ryujinx
  protonvpn-gui
  lutris
  
  qbittorrent
  pcsx2
  kdePackages.dolphin
  
  hyprshot
  nerd-fonts.noto
  noto-fonts 
  
  pavucontrol

  signal-desktop
  obsidian
  
  nwg-look

  neofetch
  nautilus

  zip
  xz
  unzip
  p7zip
  unrar
  
  ripgrep
  jq
  yq-go
  eza
  fzf
  
  mtr
  iperf3
  dnsutils
  ldns
  aria2
  socat
  nmap
  ipcalc
  
  cowsay
  file
  which
  tree
  gnused
  gnutar
  gawk
  zstd
  gnupg
  
  nix-output-monitor
  
  hugo
  glow
  
  btop
  iotop
  iftop
  
  strace
  ltrace
  lsof
  
  sysstat
  lm_sensors
  ethtool
  pciutils
  usbutils
]
