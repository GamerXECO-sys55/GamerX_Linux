# Custom Arch Linux - Multi-Profile Installer

This repository contains multiple installation profiles for custom Arch Linux builds. Each profile is completely independent with its own configurations, patches, and features.

## Available Profiles

1. **Hyprland**
   - Base system with Hyprland
   - HyDE theme integration
   - Minimal configuration

2. **Gaming**
   - Full gaming support
   - Steam, Proton, Wine
   - Gaming optimizations
   - Additional utilities

3. **Hacking**
   - Security tools
   - Tor routing
   - Auto-wipe features
   - Encryption utilities

## Repository Structure

```
arch-custom-installer/
├── Installer/
│   ├── install_hyprland.sh
│   ├── install_gaming.sh
│   └── install_hacking.sh
├── hyprland/
│   ├── configs/
│   ├── patches/
│   ├── wallpapers/
│   └── scripts/
├── gaming/
│   ├── configs/
│   ├── patches/
│   ├── wallpapers/
│   └── scripts/
├── hacking/
│   ├── configs/
│   ├── patches/
│   ├── wallpapers/
│   └── scripts/
└── docs/
    └── installation_guide.md
```

## Usage

1. Clone the repository:
```bash
git clone https://github.com/yourusername/arch-custom-installer.git
```

2. Copy installer scripts to system location:
```bash
cp Installer/* /usr/local/bin/
```

3. Run the installer from your custom installer:
```bash
bash /usr/local/bin/install_hyprland.sh
# or
bash /usr/local/bin/install_gaming.sh
# or
bash /usr/local/bin/install_hacking.sh
```

## Profile Features

### Hyprland Profile
- Custom Hyprland configuration
- HyDE theme integration
- Minimal system setup
- Basic development tools

### Gaming Profile
- Full gaming stack
- Optimized configurations
- Steam integration
- Wine/Proton setup

### Hacking Profile
- Security tools
- Tor routing
- Encryption utilities
- Auto-wipe features

## Development

Each profile folder is completely independent. You can:
1. Add new configurations
2. Update patches
3. Modify wallpapers
4. Change package lists

## License

[MIT License](LICENSE)
