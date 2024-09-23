{
  stdenv,
  lib,
  buildPythonPackage,

  riptide-lib,
  click,
  tornado,
  _riptide_certauth,
  _riptide_python-prctl,
}:
buildPythonPackage {
  pname = "riptide-proxy";
  version = "0.8.1";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-proxy.git";
    ref = "refs/tags/0.8.1";
    rev = "6be4f29fa5915965ae57b226e4c3f3793d975e74";
  };

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
    maintainers = with maintainers; [ theCapypara ];
    mainProgram = "riptide_proxy";
  };
}
