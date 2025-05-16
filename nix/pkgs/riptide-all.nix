{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  riptide-cli,
  riptide-proxy,
  riptide-engine-docker,
  riptide-db-mysql,
  riptide-plugin-php-xdebug,
}:

buildPythonPackage rec {
  pname = "riptide-all";
  version = "0.10.0";
  pyproject = true;

  src = ../..;

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    riptide-cli
    riptide-proxy
    riptide-engine-docker
    riptide-db-mysql
    riptide-plugin-php-xdebug
  ];

  doCheck = false;
  pythonImportsCheck = [ ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-all";
    description = "Tool to manage development environments for web applications using containers - Metapackage";
    license = licenses.mit;
  };
}
