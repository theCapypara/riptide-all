{
  lib,
  buildPythonPackage,

  configcrunch,
  schema,
  pyyaml,
  appdirs,
  janus,
  psutil,
  GitPython,
  python-hosts,
  python-dotenv,
}:

buildPythonPackage {
  pname = "riptide-lib";
  version = "0.9.0";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-lib.git";
    #ref = "refs/tags/0.9.0";
    rev = "f9254b0ab04ed40d7e8fcd0857f87b40d6f6f0f4";
  };

  propagatedBuildInputs = [
    configcrunch
    schema
    pyyaml
    appdirs
    janus
    psutil
    GitPython
    python-hosts
    python-dotenv
  ];

  doCheck = false; # not feasible
  pythonImportsCheck = [ "riptide" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-lib";
    description = "Tool to manage development environments for web applications using containers - Library Package";
    license = licenses.mit;
    maintainers = with maintainers; [ theCapypara ];
  };
}
