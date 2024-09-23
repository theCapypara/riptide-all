{
  lib,
  buildPythonPackage,

  riptide-lib,
  schema,
}:

buildPythonPackage {
  pname = "riptide-db-mysql";
  version = "0.9.0";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-db-mysql.git";
    #ref = "refs/tags/0.9.0";
    rev = "c298524f18c03a4b8fdbc2685db4db525fef92b6";
  };

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
    maintainers = with maintainers; [ theCapypara ];
  };
}
