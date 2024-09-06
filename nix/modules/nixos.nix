{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.riptide;

  # XXX: Should somehow use xdg.
  configDir = config.users.users."${cfg.user}".home + "/.config/riptide";
  hostsDir = "/var/riptide/${cfg.user}/hosts";

  activateScript = (import ./activate.nix) {
    inherit
      configDir
      cfg
      pkgs
      lib
      ;
    hostsFile = hostsDir + "/hosts";
  };

  packages = (import ./system-packages.nix) { inherit lib cfg pkgs; };
in
{
  options = (import ./options.nix) {
    inherit lib;
    inherit (pkgs) formats python312Packages;
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        nixpkgs.overlays = [ (import ../overlay.nix) ];

        system.userActivationScripts.activate-riptide = {
          text = activateScript;
        };

        environment.systemPackages = [ packages ];

        services.dnsmasq = lib.mkIf cfg.resolveProjectHosts {
          enable = true;
          settings = {
            hostsdir = [ hostsDir ];
          };
        };

        systemd.services.riptide = lib.mkIf cfg.proxy.enable {
          description = "Tool to manage development environments for web applications using containers - Proxy Server";
          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];

          unitConfig = {
            StartLimitInterval = 120;
            StartLimitBurst = 3;
          };

          serviceConfig = {
            ExecStart = "${packages}/bin/riptide_proxy --user ${cfg.user}";
            Restart = "always";
            RestartSec = 30;
          };
        };
      }
      (lib.mkIf cfg.resolveProjectHosts {
        systemd.tmpfiles.rules = [ "f ${hostsDir}/hosts 0664 ${cfg.user} root -" ];
      })
    ]
  );

  meta.maintainers = with lib.maintainers; [ theCapypara ];
}
