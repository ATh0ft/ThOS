{ config, pkgs, ...}:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  #users.users.a = {
  #  openssh.authorizedKeys.keyFiles = ["/home/a/.ssh/ssh-key.pub"];
  #};

}
