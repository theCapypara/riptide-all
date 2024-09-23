{
  lib,
  buildPythonPackage,

  riptide-lib,
}:

buildPythonPackage {
  pname = "riptide-engine-dummy";
  version = "0.9.0";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-dummy.git";
    #ref = "refs/tags/0.9.0";
    rev = "ad2a05723fb167b0e7f2805bbd314cf511345822";
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
