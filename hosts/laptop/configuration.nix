# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos_modules
      ../../modules/nixos_modules/git      # Import Git module
      ../../modules/nixos_modules/hyprland  # Import Hyprland module
      ../../modules/nixos_modules/openssh
      ../../modules/nixos_modules/tmux
    ];


  nixpkgs.config.allowUnfree = true;
  syncthing.enable = true;
  zerotierone.enable = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.a = {
    isNormalUser = true;
    description = "alfred";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };


  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  environment.systemPackages = with pkgs; [
    vim 
    wget
    kitty 
    home-manager
    git
    tree
    htop
    age
    inputs.agenix.packages.${pkgs.system}.default
  ];
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  

#  home-manager = {
#    useGlobalPkgs = true; 
#    useUserPackages = true;
#    users = {
#      a = import ./home.nix;
#    };
#  };

  services.syncthing = {
    #declarative = {
      overrideDevices = true;
      overrideFolders = true;
    #};
    settings = {
      folders = {
        "books" = { 
	  path = "/home/a/sync/books"; 
  	  devices = [ "eink" "workstation"]; 
  	  versioning = { 
	    type = "simple";
	    params = { 
	      keep = "10";
	    }; 
  	  }; 
	};
        "notes" = { 
 	  path = "/home/a/sync/notes"; 
 	  devices = ["eink" "workstation"]; 
	  versioning = { 
	    type = "simple"; 
  	    params = { 
	      keep = "10";
	    }; 
	  }; 
        };
      };
      devices = {
        "eink" = { id = "X5SZ3EW-G7CDNUQ-KGBK2EL-23SZV5S-YUQFLNA-AV7DKTC-TVOKJNS-XEGSJAI"; };
        "workstation" = { id = "WDMVTWV-DFMXTPI-4WDHEGU-WZ4PYYL-KPSHKJM-UCGKGDA-SRUGSFG-USWT6QB"; };
      };
    };
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

