{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  docker,
}:

buildPythonPackage rec {
  pname = "riptide-engine-docker";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-docker.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "0a3f9f304c9d0947769d55c3438b51d7876434a8";
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
