{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  docker,
}:

buildPythonPackage {
  pname = "riptide-engine-docker";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-docker.git";
    # TODO
    #ref = "refs/tags/${version}";
    ref = "refs/heads/hooks";
    rev = "dba08e88f06f6357cc12d453f5bcad19daef6605";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    docker
  ];

  doCheck = false;
  pythonImportsCheck = [
    "riptide_engine_docker"
    "docker"
  ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-engine-docker";
    description = "Tool to manage development environments for web applications using containers - Docker Implementation";
    license = licenses.mit;
  };
}
