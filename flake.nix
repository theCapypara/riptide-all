{
  description = "Riptide - Tool to manage development environments for web applications using containers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
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
      systemDependent = flake-utils.lib.eachSystem (import systems) (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          packages = {
            configcrunch = pkgs.python3Packages.configcrunch;
            riptide-lib = pkgs.python3Packages.riptide-lib;
            riptide-cli = pkgs.python3Packages.riptide-lib;
            riptide-proxy = pkgs.python3Packages.riptide-proxy;
            riptide-engine-docker = pkgs.python3Packages.riptide-engine-docker;
            riptide-engine-dummy = pkgs.python3Packages.riptide-engine-dummy;
            riptide-db-mongo = pkgs.python3Packages.riptide-db-mongo;
            riptide-db-mysql = pkgs.python3Packages.riptide-db-mysql;
            riptide-plugin-php-xdebug = pkgs.python3Packages.riptide-plugin-php-xdebug;
            riptide-all = pkgs.python3Packages.riptide-all;
            default = pkgs.python3Packages.riptide-all;
            inherit (pkgs) python3;
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
          zsh = ". riptide.hook.zsh";
          bash = ". riptide.hook.bash";
        };

        checks =
          (nixpkgs.lib.genAttrs
            [
              "aarch64-darwin"
              "x86_64-darwin"
            ]
            (system: {
              integration =
                (darwin.lib.darwinSystem {
                  inherit system;
                  modules = [
                    ./nix/test/integration_darwin.nix
                    {
                      _module.args = {
                        pkgs = nixpkgs.lib.mkForce (
                          import nixpkgs {
                            inherit system;
                            overlays = [ self.overlays.default ];
                          }
                        );
                      };
                    }
                  ];
                }).system;
            })
          )
          // (nixpkgs.lib.genAttrs
            [
              "aarch64-linux"
              "x86_64-linux"
            ]
            (system: {
              integration = import ./nix/test/integration_nixos.nix rec {
                inherit nixpkgs;
                system = "x86_64-linux";
                pkgs = import nixpkgs {
                  inherit system;
                  overlays = [ self.overlays.default ];
                };
              };
            })
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
