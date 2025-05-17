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

      # TODO: Temporary
      _riptide_tornado = python-final.callPackage ./pkgs/_forks/tornado.nix { };
      _riptide_click = python-final.callPackage ./pkgs/_forks/click.nix { };
      # typer, which is a dependency of python-on-whales, which is a test dependency of aiohttp,
      # does not support click 8.2, but it doesn't really matter for us, we don't need it.
      aiohttp = python-prev.aiohttp.overridePythonAttrs (_: {
          doCheck = false;
      });
      # similar for httpx
      httpx = python-prev.httpx.overridePythonAttrs (_: {
          doCheck = false;
      });
      python-dotenv = python-prev.python-dotenv.override {
          click = python-final.callPackage ./pkgs/_forks/click.nix { };
      };
      flask = python-prev.flask.override {
          click = python-final.callPackage ./pkgs/_forks/click.nix { };
      };
    })
  ];

  python313 =
    let
      self = prev.python313.override {
        inherit self;
        packageOverrides = prev.lib.composeManyExtensions final.pythonPackagesOverlays;
      };
    in
    self;

  python313Packages = final.python313.pkgs;
}
