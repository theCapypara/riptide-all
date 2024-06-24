final: prev: {
  pythonPackagesOverlays = (prev.pythonPackagesOverlays or [ ]) ++ [
    (python-final: python-prev: {
      configcrunch = python-final.callPackage ./pkgs/configcrunch.nix { };
      riptide-lib = python-final.callPackage ./pkgs/riptide-lib.nix { };
      riptide-cli = python-final.callPackage ./pkgs/riptide-cli.nix { };
      riptide-proxy = python-final.callPackage ./pkgs/riptide-proxy.nix { };
      riptide-engine-docker = python-final.callPackage ./pkgs/riptide-engine-docker.nix { };
      riptide-engine-dummy = python-final.callPackage ./pkgs/riptide-engine-dummy.nix { };
      riptide-db-mongo = python-final.callPackage ./pkgs/riptide-db-mongo.nix { };
      riptide-db-mysql = python-final.callPackage ./pkgs/riptide-db-mysql.nix { };
      riptide-plugin-php-xdebug = python-final.callPackage ./pkgs/riptide-plugin-php-xdebug.nix { };
      riptide-all = python-final.callPackage ./pkgs/riptide-all.nix { };

      _riptide_python-prctl = python-final.callPackage ./pkgs/python-prctl.nix { };
      _riptide_certauth = python-final.callPackage ./pkgs/certauth.nix { };
    })
  ];

  python3 =
    let
      self = prev.python3.override {
        inherit self;
        packageOverrides = prev.lib.composeManyExtensions final.pythonPackagesOverlays;
      };
    in
    self;

  python3Packages = final.python3.pkgs;
}
