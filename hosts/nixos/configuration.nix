{
  pkgs,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/disk/by-id/nvme-Samsung_SSD_990_PRO_2TB_S7HENU0Y940021J";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.extraEntries = ''
    menuentry "Arch Linux" {
      insmod part_msdos
      insmod ext2
      insmod luks
      insmod lvm
      search --no-floppy --fs-uuid --set=root c334e9d2-43de-4ab7-b365-cced491b5839
      linux /vmlinuz-linux root=/dev/mapper/vg0-arch rw intel_iommu=on cryptdevice=UUID=4280d34a-67ea-4a6b-9220-2e381f078cb2:crypt quiet
      initrd /initramfs-linux.img
    }
  '';

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    displayManager.enable = true;
    displayManager.ly.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  programs.niri.enable = true;
  programs.nix-ld.enable = true;

  users.users.jean = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs = {
    bash.enable = true;
    fish.enable = true;
    # firefox.enable = true; # using firefox-devedition via home-manager instead
    gamemode.enable = true;
    git.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    xwayland.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services.gvfs.enable = true;

  # SAVITECH LPe (262a:0001) doesn't implement USB suspend/resume properly and
  # isn't in the kernel's USB_QUIRK_RESET_RESUME table, so after suspend the
  # device clock desyncs with PipeWire, causing pitch-shifted/distorted audio.
  # Unbinding and rebinding after resume forces a clean re-enumeration.
  powerManagement.resumeCommands = ''
    dev=$(grep -rl "262a" /sys/bus/usb/devices/*/idVendor 2>/dev/null | head -1 | xargs dirname | xargs basename)
    echo -n "$dev" > /sys/bus/usb/drivers/usb/unbind
    sleep 0.5
    echo -n "$dev" > /sys/bus/usb/drivers/usb/bind
  '';

  environment.systemPackages = with pkgs; [
    # wayland desktop
    waybar
    fuzzel
    mako
    swaylock
    swayidle
    xwayland-satellite
    wl-clipboard
    swww

    # basic editors
    vim
    neovim

    # system utilities
    os-prober
    polkit_gnome
    brightnessctl
    pavucontrol
    unzip
  ];

  system.stateVersion = "25.11";
}
