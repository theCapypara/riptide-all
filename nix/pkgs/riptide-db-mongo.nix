{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  schema,
}:

buildPythonPackage rec {
  pname = "riptide-db-mongo";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-db-mongo.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "a4f6ac8b786d97823a911bc3771789ec74379efc";
  };

  nativeBuildInputs = [ setuptools ];

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
  };
}
