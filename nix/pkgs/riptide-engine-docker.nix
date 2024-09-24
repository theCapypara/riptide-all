{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  docker,
}:

buildPythonPackage {
  pname = "riptide-engine-docker";
  version = "0.9.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-docker.git";
    #ref = "refs/tags/0.9.0";
    rev = "08f47c95d42b404e817c4bbf8534cf28154147db";
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
