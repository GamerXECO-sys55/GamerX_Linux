from archinstall import Profile

class GamerXHyprland(Profile):
    name = "GamerX Hyprland"
    description = "A minimal Hyprland environment for testing."
    packages = [
        "hyprland",
        "kitty",
        "waybar",
        "xdg-desktop-portal-hyprland",
        "xdg-desktop-portal",
        "swaybg",
        "networkmanager",
        "noto-fonts",
        "noto-fonts-emoji",
        "ttf-dejavu",
        "polkit",
        "polkit-gnome",
        "pipewire",
        "wireplumber",
        "alsa-utils",
        "pulseaudio",
        "pulseaudio-alsa",
        "grim",
        "slurp",
        "wl-clipboard",
        "neovim"
    ]
    services = [
        "NetworkManager"
    ]
    post_install = [
        # Create a minimal Hyprland config for the user
        ("mkdir -p /mnt/etc/skel/.config/hypr",),
        ("echo 'exec hyprland' > /mnt/etc/skel/.xinitrc",),
        ("echo '[General]\nmonitor=,preferred,auto,1\n' > /mnt/etc/skel/.config/hypr/hyprland.conf",)
    ] 