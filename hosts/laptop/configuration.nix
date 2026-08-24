# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos_modules
  ];

  nixpkgs.config.allowUnfree = true;
  syncthing.enable = true;
  zerotierone.enable = true;
  security.rtkit.enable = true;

  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;
  # };
  # sddm.enable = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  hardware.steam-hardware.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # services.pipewire.enable = lib.mkForce false; # disable pipewiere to enable pulseaudio
  # hardware.pulseaudio.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.a = {
    isNormalUser = true;
    description = "alfred";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  services.logind = {
    lidSwitch = "poweroff";
    lidSwitchDocked = "ignore"; # optional
    lidSwitchExternalPower = "poweroff"; # optional
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    home-manager
    tree
    htop
    age
    inputs.agenix.packages.${pkgs.system}.default
    jmtpfs
    usbutils
    glib
    pavucontrol
    blueman
    pulseaudio # for pactl CLI
    alsa-utils
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  services.syncthing = {
    #declarative = {
    overrideDevices = true;
    overrideFolders = true;
    #};
    settings = {
      folders = {
        "books" = {
          path = "/home/a/sync/books";
          devices = [
            "eink"
            "workstation"
            "optiplex"
          ];
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };
        "notes" = {
          path = "/home/a/sync/notes";
          devices = [
            "eink"
            "workstation"
            "optiplex"
          ];
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };
        "coding_projects" = {
          path = "/home/a/sync/coding_projects";
          devices = [
            "workstation"
            "optiplex"
          ];
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };
        "music" = {
          path = "/home/a/sync/music";
          devices = [
            "workstation"
            "optiplex"
          ];
          versioning = {
            type = "simple";
            params = {
              keep = "2";
            };
          };
        };

        "images" = {
          path = "/home/a/sync/images";
          devices = [
            "workstation"
            "optiplex"
          ];
          versioning = {
            type = "simple";
            params = {
              keep = "2";
            };
          };
        };
      };
      devices = {
        "eink" = {
          id = "X5SZ3EW-G7CDNUQ-KGBK2EL-23SZV5S-YUQFLNA-AV7DKTC-TVOKJNS-XEGSJAI";
        };
        "workstation" = {
          id = "WDMVTWV-DFMXTPI-4WDHEGU-WZ4PYYL-KPSHKJM-UCGKGDA-SRUGSFG-USWT6QB";
        };
        "optiplex" = {
          id = "QACEZ4N-A7LPI6V-CTRA7RH-HCBGRYK-Q7Z7SKA-23JL46P-V7KQKTW-QXCKAAU";
        };
      };
    };
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    # bluetooth.enable = true;

    extraConfig.pipewire."10-bluez" = {
      "bluez5.enable-msbc" = true;
      "bluez5.enable-sbc-xq" = true;
      "bluez5.codecs" = [
        "aac"
        "sbc"
        "sbc_xq"
        "ldac"
      ];
    };
  };

  services.pipewire.wireplumber.extraConfig.bluetooth = {
    "monitor.bluez.properties" = {
      "bluez5.autoswitchSBCXQ" = true;
    };
  };

  boot.blacklistedKernelModules = [
    "snd_sof_amd_renoir"
    "snd_sof_amd_acp"
    "snd_sof_amd_acp63"
    "snd_sof_amd_acp70"
    "snd_sof_pci"
    "snd_pci_acp3x"
    "snd_rn_pci_acp3x"
    "soundwire_amd"
    "snd_acp_pci"
    "snd_pci_ps"
  ];
  boot.extraModprobeConfig = ''
    options snd_hda_intel probe_mask=1
  '';
  home-manager.users.a = {
    xdg.configFile."gtk-3.0/bookmarks".force = true;
    xdg.configFile."gtk-3.0/bookmarks".text = ''
      file:///...
    '';
  };

  fileSystems."/home/a/pictures" = {
    device = "/home/a/sync/images/laptop";
    fsType = "none";
    options = [ "bind" ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
