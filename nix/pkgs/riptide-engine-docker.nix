{
  lib,
  buildPythonPackage,

  riptide-lib,
  docker,
}:

buildPythonPackage {
  pname = "riptide-engine-docker";
  version = "0.9.0";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-engine-docker.git";
    #ref = "refs/tags/0.9.0";
    rev = "59fbe2ee6d0686c870a6f59838c6fbfbf4bbd154";
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
