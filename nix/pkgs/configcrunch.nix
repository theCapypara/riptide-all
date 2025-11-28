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
  version = "2.1.1";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/configcrunch.git";
    ref = "refs/tags/${version}";
    rev = "28519a5348e24f5935708558b51f1d7478790c3e";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-2xnpw40iS3sjTM8Gy+noqSYASk1TN9T63R2MM84r3QY=";
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
