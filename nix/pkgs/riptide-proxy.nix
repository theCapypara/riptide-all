{
  stdenv,
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  click,
  tornado,
  _riptide_certauth,
  _riptide_python-prctl,
}:
buildPythonPackage rec {
  pname = "riptide-proxy";
  version = "0.9.1";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-proxy.git";
    ref = "refs/tags/${version}";
    rev = "a81b084625aef4165fee119b81c0bc7605aac42c";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    tornado
    click
    _riptide_certauth
  ] ++ lib.optionals (stdenv.isLinux) [ _riptide_python-prctl ];

  doCheck = false;
  pythonImportsCheck = [ "riptide_proxy" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-proxy";
    description = "Tool to manage development environments for web applications using containers - HTTP and WebSocket Reverse Proxy Server";
    license = licenses.mit;
    mainProgram = "riptide_proxy";
  };
}
