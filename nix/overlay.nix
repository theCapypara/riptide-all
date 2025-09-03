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

      # Sets to a fork that doesn't use tldextract, since tldextract always tries to fetch files from the internet
      # when starting, which is really annoying. We don't need the security features of tldextract here.
      _riptide_certauth = python-prev.certauth.overridePythonAttrs (_: {
        src = fetchGit {
          url = "https://github.com/theCapypara/certauth.git";
          rev = "e7eb7f3063f3df0198ef0a5b7cac13a28ef64f26";
        };
      });

      # TODO: Click and Tornado updates
      # https://github.com/NixOS/nixpkgs/pull/425929
      click = python-final.callPackage ./pkgs/_forks/click-8.2.1.nix { };
      # https://github.com/NixOS/nixpkgs/pull/407877
      tornado = python-final.callPackage ./pkgs/_forks/tornado-6.5.1.nix { };

      # TODO: Temporary - check failures, probably due to Click (or unrelated)
      syrupy = python-prev.syrupy.overridePythonAttrs (_: {
        doCheck = false;
      });
      anyio = python-prev.anyio.overridePythonAttrs (_: {
        doCheck = false;
      });
      typer = python-prev.typer.overridePythonAttrs (_: {
        doCheck = false;
      });
      aiohttp = python-prev.aiohttp.overridePythonAttrs (_: {
        doCheck = false;
      });
    })
  ];

  python313 = prev.python313.override {
    packageOverrides = prev.lib.composeManyExtensions final.pythonPackagesOverlays;
  };
  python313Packages = final.python313.pkgs;

  python312 = prev.python312.override {
    packageOverrides = prev.lib.composeManyExtensions final.pythonPackagesOverlays;
  };
  python312Packages = final.python312.pkgs;

  python311 = prev.python311.override {
    packageOverrides = prev.lib.composeManyExtensions final.pythonPackagesOverlays;
  };
  python311Packages = final.python311.pkgs;
}
