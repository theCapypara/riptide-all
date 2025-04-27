{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  schema,
}:

buildPythonPackage rec {
  pname = "riptide-db-mongo";
  version = "0.9.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-db-mongo.git";
    ref = "refs/tags/${version}";
    rev = "a9d7be47398e8b43d903aa6199b53ffc6073a1a6";
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
