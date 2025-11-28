{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
}:

buildPythonPackage rec {
  pname = "riptide-engine-dummy";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-dummy.git";
    ref = "refs/tags/${version}";
    rev = "fd3963ac3739491014e6de8edf035e8aeb2eb40d";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [ riptide-lib ];

  doCheck = false;
  pythonImportsCheck = [ "riptide_engine_dummy" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-engine-dummy";
    description = "Dummy Riptide engine implementation for tests";
    license = licenses.mit;
  };
}
