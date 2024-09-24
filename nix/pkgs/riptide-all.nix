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

buildPythonPackage {
  pname = "riptide-all";
  version = "0.9.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-all.git";
    ref = "refs/tags/0.9.0";
    rev = "9509dd2dbc5d03b706c857b4d9aad7ea07dcb892";
  };

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
