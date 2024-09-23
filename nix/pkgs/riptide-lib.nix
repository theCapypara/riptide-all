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
  version = "0.8.2";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-lib.git";
    #ref = "refs/tags/0.8.2";
    rev = "a9239f49cf88885973ad7064b21fb1f4f2296b7e";
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
