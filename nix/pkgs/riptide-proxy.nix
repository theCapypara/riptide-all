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
buildPythonPackage rec {
  pname = "riptide-proxy";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-proxy.git";
    ref = "refs/tags/${version}";
    rev = "b26e56dad19bb70e6abbda5a01f3ec3a6ef792de";
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
