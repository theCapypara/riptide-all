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
    ref = "refs/tags/${version}";
    rev = "d815940a9627d027cbbc7445ff2d696c9d516a9e";
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
