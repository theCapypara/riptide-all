{
  lib,
  buildPythonPackage,

  riptide-lib,
  schema,
}:

buildPythonPackage {
  pname = "riptide-db-mongo";
  version = "0.8.0";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-db-mongo.git";
    ref = "refs/tags/0.8.0";
    rev = "55ceb402d3ee71088ad56a2292318cdfc475e4e4";
  };

  propagatedBuildInputs = [
    riptide-lib
    schema
  ];

  doCheck = false;
  pythonImportsCheck = [ "riptide_db_mongo" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-db-mongo";
    description = "Tool to manage development environments for web applications using containers - MongoDB database driver";
    license = licenses.mit;
    maintainers = with maintainers; [ theCapypara ];
  };
}
