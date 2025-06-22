{
  config,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  networking.firewall.allowedTCPPorts = [22];

  environment.systemPackages = with pkgs; [
    xorg.xauth
    xorg.xhost
  ];

  # Optional: uncomment and configure for key-based auth
  # users.users.a = {
  #   openssh.authorizedKeys.keyFiles = [ "/home/a/.ssh/ssh-key.pub" ];
  # };
}
