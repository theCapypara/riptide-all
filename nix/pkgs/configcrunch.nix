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
}:
buildPythonPackage {
  pname = "configcrunch";
  version = "1.0.5";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/configcrunch.git";
    ref = "refs/tags/1.0.5";
    rev = "065acac7fb73c6aee17957714c8ff8a37f7e781a";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "minijinja-0.8.2" = "sha256-IvyfWFu13clP65mvHhuaJ9Mtpe9Gwf0xVANMOxBx84E=";
    };
  };

  nativeBuildInputs = [
    setuptools-rust
    rustPlatform.cargoSetupHook
    cargo
    rustc
  ];
  propagatedBuildInputs = [ schema ];

  nativeCheckInputs = [
    pytestCheckHook
    pyyaml
  ];
  pytestFlagsArray = [ "tests/" ];

  postPatch = ''
    # to be able to run tests (include ymls) - XXX: should probably be fixed upstream
    echo "recursive-include configcrunch/tests *" >> MANIFEST.in
  '';

  preCheck = ''
    # pytestCheckHook puts . at the front of Python's sys.path, due to:
    # https://github.com/NixOS/nixpkgs/issues/255262
    # So we need to prevent pytest from trying to import configfrunch from
    # ./configfrunch, which contains the sources but not the newly built module.
    # We want it to import configfrunch from the nix store via $PYTHONPATH instead.
    mv configcrunch/tests tests
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
    maintainers = with maintainers; [ theCapypara ];
  };
}
