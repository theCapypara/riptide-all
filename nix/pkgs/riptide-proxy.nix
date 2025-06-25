{
  stdenv,
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  _riptide_click,
  tornado,
  _riptide_certauth,
  python-prctl,
}:
buildPythonPackage rec {
  pname = "riptide-proxy";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-proxy.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "e755e36cab638b547a8c77b586cad658975e5a9b";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    tornado
    _riptide_click
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
