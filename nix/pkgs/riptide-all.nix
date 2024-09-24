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
    #ref = "refs/tags/0.9.0";
    rev = "3cdfae33fb6c134cac1f8169aca219d432d11932";
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
