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
buildPythonPackage rec {
  pname = "configcrunch";
  version = "1.1.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/configcrunch.git";
    ref = "refs/tags/1.1.0.post1";
    rev = "da31e6055147ee67e4e2130cb3d04aae06ee7454";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-eJeNq6cK5eFHTAE8mX6j3ZxqTV+FHQpq+7RvoyoMadc=";
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

  preCheck = ''
    # pytestCheckHook puts . at the front of Python's sys.path, due to:
    # https://github.com/NixOS/nixpkgs/issues/255262
    # So we need to prevent pytest from trying to import configfrunch from
    # ./configfrunch, which contains the sources but not the newly built module.
    # We want it to import configfrunch from the nix store via $PYTHONPATH instead.
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
