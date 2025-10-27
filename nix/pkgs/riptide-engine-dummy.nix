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
    rev = "eee154af3fec50c2cfcd18c13fdf054f04bad556";
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
