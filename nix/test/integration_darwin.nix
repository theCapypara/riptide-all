{
  nixpkgs ? <nixpkgs>,
  system ? builtins.currentSystem,
  ...
}:
let
  pkgs = import nixpkgs {
    inherit system;
    overlays = [ (import ../overlay.nix) ];
  };
in
{
  imports = [ ../modules/darwin.nix ];

  # TODO: We don't actually test that Riptide is working yet.

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
      package = pkgs.python312Packages.riptide-engine-dummy;
    };
    proxy = {
      enable = true;
      ports = {
        http = 8080;
      };
    };
  };
}
