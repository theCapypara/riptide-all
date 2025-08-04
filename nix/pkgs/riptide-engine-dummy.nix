{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
}:

buildPythonPackage {
  pname = "riptide-engine-dummy";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-dummy.git";
    # TODO
    #ref = "refs/tags/${version}";
    ref = "refs/heads/add-linting";
    rev = "d1f4dec975f8c5a2f73c0c129c5d13c4d77469fd";
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
