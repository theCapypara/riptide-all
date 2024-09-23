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
            configcrunch = pkgs.python312Packages.configcrunch;
            riptide-lib = pkgs.python312Packages.riptide-lib;
            riptide-cli = pkgs.python312Packages.riptide-cli;
            riptide-proxy = pkgs.python312Packages.riptide-proxy;
            riptide-engine-docker = pkgs.python312Packages.riptide-engine-docker;
            riptide-engine-dummy = pkgs.python312Packages.riptide-engine-dummy;
            riptide-db-mongo = pkgs.python312Packages.riptide-db-mongo;
            riptide-db-mysql = pkgs.python312Packages.riptide-db-mysql;
            riptide-plugin-php-xdebug = pkgs.python312Packages.riptide-plugin-php-xdebug;
            riptide-all = pkgs.python312Packages.riptide-all;
            default = pkgs.python312Packages.riptide-all;
            inherit (pkgs) python312;
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
                        inherit nixpkgs system;
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
