{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  setuptools-scm,
  wheel,
}:

# XXX: Disable tests, rich isn't building.
buildPythonPackage rec {
  pname = "tqdm";
  version = "4.66.4";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-5Nk2yd6HJ5KPO+YHlZDpfZq/6NOaWQvmeOtZGf/Bhrs=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
    wheel
  ];

  doCheck = false;
  dontCheck = true;

  LC_ALL = "en_US.UTF-8";

  pythonImportsCheck = [ "tqdm" ];

  meta = with lib; {
    description = "Fast, Extensible Progress Meter";
    mainProgram = "tqdm";
    homepage = "https://github.com/tqdm/tqdm";
    changelog = "https://tqdm.github.io/releases/";
    license = with licenses; [ mit ];
  };
}
