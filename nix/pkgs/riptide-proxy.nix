{
  stdenv,
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  _riptide_click,
  _riptide_tornado,
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
    rev = "7508ae61c87735d6dcfcf0844299e8e837de72dc";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    _riptide_tornado
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
