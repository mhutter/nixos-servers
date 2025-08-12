{
  pkgs,
  lib,
  modulesPath,
  username,
  ...
}:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [ username ];
  };

  environment.systemPackages = with pkgs; [
    git
    htop
    tmux
    vim
  ];

  documentation = {
    enable = false;
    man.enable = false;
    info.enable = false;
    doc.enable = false;
  };

  fileSystems = lib.mkDefault {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
      autoResize = true;
    };
  };

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  boot = {
    loader.grub.enable = true;
    loader.grub.device = "/dev/sda";
    initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "virtio_pci"
      "virtio_scsi"
      "sd_mod"
      "sr_mod"
      "ext4"
    ];
    growPartition = true;
  };

  users.users = {
    root.hashedPassword = "!"; # Disable root login
    "${username}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAintE57orNe9iBBS6Ufg2hrV5ax+gL+Vx7X7K0TRWPc mh@rotz2025"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIERnSasc2L5AHp+uPCc+gCwF5HoPP5i2bnwwYycYfbpn mh@nzxt2025"
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = [ username ];
    };
  };

  networking = {
    useDHCP = true;
    domain = lib.mkDefault "mhnet.dev";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "25.05";
}
