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
    rev = "276e3b6b66add47fdcdf65b4426363072e66852a";
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
