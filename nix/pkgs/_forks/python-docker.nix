{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,

  # build-system
  hatchling,
  hatch-vcs,

  # dependencies
  packaging,
  requests,
  urllib3,

  # optional-dependenices
  paramiko,
  websocket-client,
}:

# XXX: Removes optional dependencies from checks. (paramiko does not build atm.). Also disables tests, they NEED paramiko...
buildPythonPackage rec {
  pname = "docker";
  version = "7.1.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "docker";
    repo = "docker-py";
    rev = "refs/tags/${version}";
    hash = "sha256-sk6TZLek+fRkKq7kG9g6cR9lvfPC8v8qUXKb7Tq4pLU=";
  };

  build-system = [
    hatchling
    hatch-vcs
  ];

  dependencies = [
    packaging
    requests
    urllib3
  ];

  optional-dependencies = {
    ssh = [ paramiko ];
    tls = [ ];
    websockets = [ websocket-client ];
  };

  doCheck = false;
  dontCheck = true;

  meta = with lib; {
    changelog = "https://github.com/docker/docker-py/releases/tag/${version}";
    description = "API client for docker written in Python";
    homepage = "https://github.com/docker/docker-py";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
