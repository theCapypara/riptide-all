{
  lib,
  buildPythonPackage,

  riptide-lib,
  docker,
}:

buildPythonPackage {
  pname = "riptide-engine-docker";
  version = "0.8.1";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-docker.git";
    ref = "refs/tags/0.8.1";
    rev = "5c7b5997ad473452c3b03b0efa2d55153ede091c";
  };

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
    maintainers = with maintainers; [ theCapypara ];
  };
}
