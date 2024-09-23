{
  lib,
  buildPythonPackage,

  riptide-lib,
  schema,
}:

buildPythonPackage {
  pname = "riptide-db-mysql";
  version = "0.8.1";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-db-mysql.git";
    ref = "refs/tags/0.8.1";
    rev = "f2fc63eedeae2cf3dc8f7b91608e3eeef9bed84a";
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
