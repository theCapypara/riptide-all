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
    rev = "2dab6ff304af427c0146c525f089d91fbd3ff5a7";
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
