{
  stdenv,
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  click,
  tornado,
  _riptide_certauth,
  python-prctl,
}:
buildPythonPackage {
  pname = "riptide-proxy";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-proxy.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "46893d0a987a0e88584204e15d2d7be20780c6a1";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    tornado
    click
    _riptide_certauth
  ] ++ lib.optionals (stdenv.isLinux) [ python-prctl ];

  doCheck = false;
  pythonImportsCheck = [ "riptide_proxy" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-proxy";
    description = "Tool to manage development environments for web applications using containers - HTTP and WebSocket Reverse Proxy Server";
    license = licenses.mit;
    mainProgram = "riptide_proxy";
  };
}
