{
  mkShell,
  python312,
  cargo,
  rustc,
  rustfmt,
  clippy,
  openssl,
  pkg-config,
  cargo-deny,
  cargo-edit,
  cargo-watch,
  rust-analyzer,
  stdenv,
  lib,
}:
mkShell {
  name = "riptide";

  packages =
    # PYTHON
    [ python312 ]
    ++ (
      with python312.pkgs;
      [
        pip
        setuptools
        setuptools-rust
        certauth
      ]
      ++ lib.optionals (stdenv.isLinux) [ (callPackage ./pkgs/_forks/python-prctl.nix { }) ]
    )
    ++
      # # RUST
      ([
        cargo
        rustc
        rustfmt
        clippy
        openssl
        pkg-config
        cargo-deny
        cargo-edit
        cargo-watch
        rust-analyzer
      ])
    ## OTHER
    ++ [ stdenv.cc.cc.lib ];

  # Expsose venv for simpler integration with editors & IDEs.
  # This should be enough for IDEs & LSPs but may not be enough to run
  # riptide by just activating the venv!
  shellHook = ''
    export LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib/:$LD_LIBRARY_PATH

    SOURCE_DATE_EPOCH=$(date +%s)
    VENV=~/.riptide_venv

    if test ! -d $VENV; then
      python3.12 -m venv $VENV
    fi
    source $VENV/bin/activate
    export PYTHONPATH=`pwd`/$VENV/${python312.sitePackages}/:$PYTHONPATH
    # Link all packages
    ( IFS=:
      for p in $PYTHONPATH; do
          ln -sf $p/* $VENV/lib/python3.12/site-packages 2> /dev/null
      done
    )
    export IN_NIX_SHELL="riptide"
  '';
}
