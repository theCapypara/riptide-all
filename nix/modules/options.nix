{ lib, pkgs }:
let
  inherit (lib) types;

  mkSimplePackageSwitch =
    {
      pkgName,
      description,
      default,
    }:
    lib.mkOption {
      type = types.submodule {
        options = {
          enable = lib.mkEnableOption description // {
            inherit default;
          };
          package = lib.mkPackageOption pkgs [
            "python3Packages"
            pkgName
          ] { };
        };
      };
      default = { };
    };
in
{
  services.riptide = {
    enable = lib.mkEnableOption "Riptide general service and CLI";

    cli = lib.mkOption {
      type = types.submodule {
        options = {
          package = lib.mkPackageOption pkgs [
            "python3Packages"
            "riptide-cli"
          ] { };
        };
      };
      default = { };
    };

    dbDrivers = lib.mkOption {
      type = types.submodule {
        options = {
          mysql = mkSimplePackageSwitch {
            pkgName = "riptide-db-mysql";
            description = "Riptide MySQL database driver";
            default = true;
          };
          mongodb = mkSimplePackageSwitch {
            pkgName = "riptide-db-mongo";
            description = "Riptide MongoDB database driver";
            default = false;
          };
        };
      };
      default = { };
    };

    plugins = lib.mkOption {
      type = types.submodule {
        options = {
          phpXdebug = mkSimplePackageSwitch {
            pkgName = "riptide-plugin-php-xdebug";
            description = "Riptide Plugin to manage the state of PHP Xdebug";
            default = true;
          };
        };
      };
      default = { };
    };

    user = lib.mkOption {
      type = types.str;
      example = "yourUser";
      description = ''
        The user to run the Riptide proxy as (if enabled) and the user for which
        the configuration file will be created.
      '';
    };

    dockerHost = lib.mkOption {
      type = types.str;
      example = "unix:///run/user/1000/podman/podman.sock";
      default = "";
      description = ''
        Override the docker/podman socket Riptide connects to. Only relevant if
        `engine = "docker"`. Tries to auto-detect by default.
      '';
    };

    proxy = lib.mkOption {
      type = types.submodule {
        options = {
          enable = lib.mkEnableOption "Riptide Proxy Server" // {
            default = true;
          };
          package = lib.mkPackageOption pkgs [
            "python3Packages"
            "riptide-proxy"
          ] { };

          url = lib.mkOption {
            type = types.str;
            example = "riptide.local";
            default = "riptide.local";
            description = ''
              The prefix that you want your projects to be accessible
              under. riptide.local -> projectname.riptide.local
            '';
          };

          ports = lib.mkOption {
            type = types.submodule {
              options = {
                http = lib.mkOption {
                  type = types.port;
                  example = 80;
                  default = 80;
                  description = "The HTTP port the proxy server should bind to";
                };
                https = lib.mkOption {
                  type = types.port;
                  example = 443;
                  default = 443;
                  description = "The HTTPS port the proxy server should bind to.";
                };
              };
            };
            default = { };
          };

          autostart = lib.mkOption {
            type = types.bool;
            default = true;
            description = "Enable or disable auto-starting when a project or service is not running.";
          };
        };
      };
      default = { };
    };

    repos = lib.mkOption {
      type = types.listOf types.str;
      default = [ "https://github.com/theCapypara/riptide-repo.git" ];
      example = [
        "https://github.com/theCapypara/riptide-repo.git"
        "https://github.com/foobar/repo.git"
      ];
      description = "List of Riptide repositories. By default this contains the public community repository.";
    };

    resolveProjectHosts = lib.mkOption {
      type = types.bool;
      default = true;
      description = ''
        If enabled, project URLs are locally resolvable. 
        Under NixOS this will install the dnsmasq service, if not already installed.
        Under nix-darwin, the /etc/hosts file will be modified by Riptide.
      '';
    };

    engine = lib.mkOption {
      type = types.submodule {
        options = {
          name = lib.mkOption {
            type = types.str;
            default = "docker";
            description = "Riptide engine implementation to use.";
          };
          package = lib.mkPackageOption pkgs [
            "python3Packages"
            "riptide-engine-docker"
          ] { };
        };
      };
      default = { };
    };

    extraConfig = lib.mkOption {
      description = "Additional configuration to merge into the system configuration.";
      type = types.submodule {
        freeformType = (pkgs.formats.json { }).type;
        options = { };
      };
      default = { };
    };
  };
}
