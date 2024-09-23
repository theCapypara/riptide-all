{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.riptide;

  configDir = config.users.users."${cfg.user}".home + "Library/Application Support/riptide";

  activateScript = (import ./activate.nix) {
    inherit
      configDir
      cfg
      pkgs
      lib
      ;
    hostsFile = "NONE";
  };

  packages = (import ./system-packages.nix) { inherit lib cfg pkgs; };
in
{
  options = (import ./options.nix) {
    inherit lib;
    inherit (pkgs) formats python312Packages;
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ (import ../overlay.nix) ];

    launchd.user.agents.activate-riptide = {
      script = ''
        set -e
        set -o pipefail
        export PATH="${pkgs.gnugrep}/bin:${pkgs.coreutils}/bin:@out@/sw/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        ${activateScript}
        exit 0
      '';
      serviceConfig = {
        RunAtLoad = true;
        KeepAlive.SuccessfulExit = false;
      };
    };

    environment.systemPackages = [ packages ];

    launchd.user.agents.riptide = lib.mkIf cfg.proxy.enable {
      command = "${packages}/bin/riptide_proxy";
      serviceConfig.KeepAlive = true;
    };
  };

  meta.maintainers = with lib.maintainers; [ theCapypara ];
}
