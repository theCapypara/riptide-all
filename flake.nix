{
  description = "Riptide - Tool to manage development environments for web applications using containers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      darwin,
      flake-utils,
    }:
    let
      makePkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };

      systemDependent = flake-utils.lib.eachSystem (import systems) (
        system:
        let
          pkgs = makePkgs system;
        in
        {
          packages = {
            configcrunch = pkgs.python313Packages.configcrunch;
            riptide-lib = pkgs.python313Packages.riptide-lib;
            riptide-cli = pkgs.python313Packages.riptide-cli;
            riptide-proxy = pkgs.python313Packages.riptide-proxy;
            riptide-engine-docker = pkgs.python313Packages.riptide-engine-docker;
            riptide-engine-dummy = pkgs.python313Packages.riptide-engine-dummy;
            riptide-db-mongo = pkgs.python313Packages.riptide-db-mongo;
            riptide-db-mysql = pkgs.python313Packages.riptide-db-mysql;
            riptide-plugin-php-xdebug = pkgs.python313Packages.riptide-plugin-php-xdebug;
            riptide-all = pkgs.python313Packages.riptide-all;
            default = pkgs.python313Packages.riptide-all;
            inherit (pkgs) python313;
          };

          devShells = {
            default = pkgs.callPackage ./nix/dev-shell.nix { };
          };
        }
      );

      systemIndependent = {
        nixosModules.riptide = import ./nix/modules/nixos.nix;
        nixosModules.default = self.nixosModules.riptide;

        darwinModules.riptide = import ./nix/modules/darwin.nix;
        darwinModules.default = self.darwinModules.riptide;

        # Can be added to zsh/bash etc.
        # Currently nix flake check warns on this, see: https://discourse.nixos.org/t/custom-flake-outputs-for-checks/18877/4
        riptideShellIntegration = {
          zsh = ". <(nix-riptide.hook.zsh)";
          bash = ". <(nix-riptide.hook.bash)";
        };

        checks =
          let
            makePkgsChecks =
              system: ver:
              let
                pkgs = makePkgs system;
              in
              {
                "configcrunch${ver}" = pkgs."python${ver}Packages".configcrunch;
                "riptide-lib${ver}" = pkgs."python${ver}Packages".riptide-lib;
                "riptide-cli${ver}" = pkgs."python${ver}Packages".riptide-cli;
                "riptide-proxy${ver}" = pkgs."python${ver}Packages".riptide-proxy;
                "riptide-engine-docker${ver}" = pkgs."python${ver}Packages".riptide-engine-docker;
                "riptide-engine-dummy${ver}" = pkgs."python${ver}Packages".riptide-engine-dummy;
                "riptide-db-mongo${ver}" = pkgs."python${ver}Packages".riptide-db-mongo;
                "riptide-db-mysql${ver}" = pkgs."python${ver}Packages".riptide-db-mysql;
                "riptide-plugin-php-xdebug${ver}" = pkgs."python${ver}Packages".riptide-plugin-php-xdebug;
                "riptide-all${ver}" = pkgs."python${ver}Packages".riptide-all;
              };
          in
          (nixpkgs.lib.genAttrs
            [
              "aarch64-darwin"
              "x86_64-darwin"
            ]
            (
              system:
              (
                {
                  integration =
                    (darwin.lib.darwinSystem {
                      inherit system;
                      modules = [
                        ./nix/test/integration_darwin.nix
                        {
                          _module.args = {
                            inherit nixpkgs system;
                            pkgs = makePkgs system;
                          };
                        }
                      ];
                    }).system;
                }
                // (makePkgsChecks system "313")
                // (makePkgsChecks system "312")
                // (makePkgsChecks system "311")
              )
            )
          )
          // (nixpkgs.lib.genAttrs
            [
              "aarch64-linux"
              "x86_64-linux"
            ]
            (
              system:
              (
                {
                  integration = import ./nix/test/integration_nixos.nix rec {
                    inherit nixpkgs system;
                    pkgs = makePkgs system;
                  };
                }
                // (makePkgsChecks system "313")
                // (makePkgsChecks system "312")
                // (makePkgsChecks system "311")
              )
            )
          );

        darwinConfigurations.integration-x86_64.system = self.checks.x86_64-darwin.integration;
        darwinConfigurations.integration-aarch64.system = self.checks.aarch64-darwin.integration;

        overlays = {
          default = import ./nix/overlay.nix;
        };
      };
    in
    systemDependent // systemIndependent;
}
