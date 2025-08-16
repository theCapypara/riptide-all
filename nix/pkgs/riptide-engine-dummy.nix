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
    rev = "b43699d19dd258dfc016fef6b3e9f7cd799a65aa";
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
