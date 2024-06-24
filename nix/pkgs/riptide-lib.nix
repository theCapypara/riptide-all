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
    rev = "3a7124ff4d17816ba52ade3b4fa57612f74addfc";
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
