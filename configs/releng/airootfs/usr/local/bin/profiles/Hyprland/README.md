# Custom Arch Linux - Hyprland Profile

This profile provides a base Hyprland installation with HyDE theme and essential configurations.

## Features

- Minimal Arch Linux base system
- Hyprland window manager
- HyDE theme integration
- Basic system configurations
- Essential development tools

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/custom-arch-hyprland.git
```

2. Run the installation script:
```bash
./install.sh
```

## Configuration Structure

```
Hyprland/
├── configs/
│   ├── hyprland/
│   │   ├── hyprland.conf
│   │   └── hyprland.rules
│   ├── grub/
│   │   └── grub.cfg
│   ├── system/
│   │   ├── systemd/
│   │   └── network/
│   └── themes/
│       └── hyde/
├── patches/
│   ├── hyprland/
│   └── system/
├── scripts/
│   ├── install.sh
│   └── post-install.sh
└── packages/
    └── package-list.txt
```
