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
  GitPython,
  python-hosts,
  python-dotenv,
}:

buildPythonPackage {
  pname = "riptide-lib";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-lib.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "0870d3d6887640f40ed0544c712ed3d9b3372da7";
  };

  nativeBuildInputs = [ setuptools ];

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
  };
}
