{ config, pkgs, ... }:

{
  # Install Git
  environment.systemPackages = with pkgs; [ git ];

  # Optional: Configure Git globally
  programs.git = {
    enable = true;
    config = {
      user.name = "ATh0ft";
      user.email = "alfred@thoft.dk";
      core.editor = "vim";  # Change to vim, emacs, etc. if preferred
    };
  };
}

