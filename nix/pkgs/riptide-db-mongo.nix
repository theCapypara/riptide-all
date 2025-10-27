{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  schema,
}:

buildPythonPackage {
  pname = "riptide-db-mongo";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-db-mongo.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "29a4d51b8a675fc0af8993da4df38655e4c581e8";
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
