{
  lib,
  buildPythonPackage,
  cargo,
  rustPlatform,
  rustc,
  setuptools-rust,
  schema,
  pyyaml,
  pytestCheckHook,
  iconv,
  stdenv,
}:
buildPythonPackage rec {
  pname = "configcrunch";
  version = "1.2.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/configcrunch.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "880021564a62607faa8274db269441305930aa7a";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-gvI3qt0sb/xLPvdeOcTPaT8Kjr9BF7m0d4BsceWTiA0=";
  };

  nativeBuildInputs = [
    setuptools-rust
    rustPlatform.cargoSetupHook
    cargo
    rustc
  ];

  # https://github.com/nix-community/home-manager/issues/3482
  buildInputs = [ ] ++ lib.optionals stdenv.isDarwin [ iconv ];

  propagatedBuildInputs = [ schema ];

  # TODO: I have no idea why sometimes under macOS just with Nix the test fail. They complain
  # about abtract classes, I don't get it.
  nativeCheckInputs = [ pyyaml ] ++ lib.optionals stdenv.isLinux [ pytestCheckHook ];

  preCheck = ''
    # pytestCheckHook puts . at the front of Python's sys.path, due to:
    # https://github.com/NixOS/nixpkgs/issues/255262
    # So we need to prevent pytest from trying to import configcrunch from
    # ./configcrunch, which contains the sources but not the newly built module.
    # We want it to import configcrunch from the nix store via $PYTHONPATH instead.
    rm -r configcrunch
  '';

  pythonImportsCheck = [
    "configcrunch"
    "configcrunch._main"
  ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/configcrunch";
    description = "Configuration parser based on YAML-Files with support for variables, overlaying and hierarchies";
    license = licenses.mit;
  };
}
