{
  mkShell,
  python313,
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
let
  python = python313;
  pyVersion = "3.13";
in
mkShell {
  name = "riptide";

  packages =
    # PYTHON
    [ python ]
    ++ (
      with python.pkgs;
      [
        pip
        setuptools
        setuptools-rust
        certauth
        tox
        pytest
      ]
      ++ lib.optionals (stdenv.isLinux) [ python.pkgs.python-prctl ]
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

  # Expose venv for simpler integration with editors & IDEs.
  # This should be enough for IDEs & LSPs but may not be enough to run
  # riptide by just activating the venv!
  shellHook = ''
    export LD_LIBRARY_PATH=${stdenv.cc.cc.lib}/lib/:$LD_LIBRARY_PATH

    SOURCE_DATE_EPOCH=$(date +%s)
    VENV=~/.riptide_venv

    if test ! -d $VENV; then
      python${pyVersion} -m venv $VENV
    fi
    source $VENV/bin/activate
    export PYTHONPATH=`pwd`/$VENV/${python.sitePackages}/:$PYTHONPATH
    # Link all packages
    ( IFS=:
      for p in $PYTHONPATH; do
          ln -sf $p/* $VENV/lib/python${pyVersion}/site-packages 2> /dev/null
      done
    )
    export IN_NIX_SHELL="riptide"
  '';
}
