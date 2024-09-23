{
  lib,
  buildPythonPackage,

  riptide-lib,
  riptide-cli,
  riptide-proxy,
  riptide-engine-docker,
  riptide-db-mysql,
  riptide-plugin-php-xdebug,
}:

buildPythonPackage {
  pname = "riptide-all";
  version = "0.8.0";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-all.git";
    ref = "refs/tags/0.8.0";
    rev = "43bb985ac56fd687ef3c2ac94818d3b7e2606f07";
  };

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
    maintainers = with maintainers; [ theCapypara ];
  };
}
