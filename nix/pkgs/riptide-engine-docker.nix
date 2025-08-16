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
    rev = "e2506d519a5f280ba494764aa02524c0038b441b";
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
