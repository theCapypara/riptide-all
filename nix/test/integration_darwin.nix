{
  pkgs ? import <nixpkgs> {
    inherit system;
    config = { };
    overlays = [ (import ../overlay.nix) ];
  },
  system ? builtins.currentSystem,
  ...
}:
let
  testScript = pkgs.writeShellApplication {
    name = "riptide-integration";
    text = ''
      exit 1
    '';
  };
in
{
  imports = [ ../modules/darwin.nix ];

  services.nix-daemon.enable = true;

  environment.systemPackages = [ testScript ];

  system.activationScripts.checks.text = ''
    testScript
  '';

  users = {
    knownUsers = [ "nixriptidetester" ];
    users = {
      nixriptidetester = {
        isHidden = true;
        createHome = true;
        uid = 1100;
      };
    };
  };

  services.riptide = {
    enable = true;
    user = "nixriptidetester";
    engine = {
      name = "dummy";
      package = pkgs.python3Packages.riptide-engine-dummy;
    };
    proxy = {
      enable = true;
      ports = {
        http = 8080;
      };
    };
  };
}
