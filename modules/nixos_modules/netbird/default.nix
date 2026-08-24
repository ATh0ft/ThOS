{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ netbird ];
  services.netbird = {
    enable = true;
  };

  networking.firewall = {
    enable = true;

    # NetBird control plane (HTTPS)
    allowedTCPPorts = [ 443 ];

    # NetBird NAT traversal + WireGuard
    allowedUDPPorts = [
      3478 # STUN
      51820 # WireGuard (default, may vary)
    ];

    # Let NetBird manage its own interface
    trustedInterfaces = [ "wt0" ];

    checkReversePath = "loose";
    # Good hygiene for VPNs
    allowPing = true;
  };

}
