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
    rev = "286d9f49aaa4e5ba0b920784d92e2fc44ad95845";
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
