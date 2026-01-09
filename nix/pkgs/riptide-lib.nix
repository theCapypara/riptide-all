{
  lib,
  buildPythonPackage,
  setuptools,

  configcrunch,
  schema,
  pyyaml,
  appdirs,
  janus,
  psutil,
  gitpython,
  python-hosts,
  python-dotenv,
}:

buildPythonPackage rec {
  pname = "riptide-lib";
  version = "0.10.1";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-lib.git";
    ref = "refs/tags/${version}";
    rev = "644cf41c879e2972cb577ba162d92d4e17762fb2";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    configcrunch
    schema
    pyyaml
    appdirs
    janus
    psutil
    gitpython
    python-hosts
    python-dotenv
  ];

  doCheck = false; # not feasible
  pythonImportsCheck = [ "riptide" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-lib";
    description = "Tool to manage development environments for web applications using containers - Library Package";
    license = licenses.mit;
  };
}
