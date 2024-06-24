{
  lib,
  buildPythonPackage,

  riptide-lib,
}:

buildPythonPackage {
  pname = "riptide-engine-dummy";
  version = "0.8.0";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-dummy.git";
    #ref = "refs/tags/0.8.1";
    rev = "c39431cc35909565d40330f5a08db989ae7f0ae5";
  };

  propagatedBuildInputs = [ riptide-lib ];

  doCheck = false;
  pythonImportsCheck = [ "riptide_engine_dummy" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-engine-dummy";
    description = "Dummy Riptide engine implementation for tests";
    license = licenses.mit;
    maintainers = with maintainers; [ theCapypara ];
  };
}
