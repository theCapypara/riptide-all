{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  schema,
}:

buildPythonPackage rec {
  pname = "riptide-db-mysql";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-db-mysql.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "a05ad84586b157289a30407b2c72a93d0efd303c";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    schema
  ];

  doCheck = false;
  pythonImportsCheck = [ "riptide_db_mysql" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-db-mysql";
    description = "Tool to manage development environments for web applications using containers - MySQL database driver";
    license = licenses.mit;
  };
}
