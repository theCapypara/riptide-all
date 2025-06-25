{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  docker,
}:

buildPythonPackage rec {
  pname = "riptide-engine-docker";
  version = "0.9.2";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-docker.git";
    ref = "refs/tags/${version}";
    rev = "f3160668fe602d2303c0b4e2ba82a5cb583e1086";
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
