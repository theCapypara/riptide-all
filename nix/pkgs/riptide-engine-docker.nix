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
    rev = "17e6ce5b4b7c3bdef0bf413c8b255ffcac7e5af7";
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
