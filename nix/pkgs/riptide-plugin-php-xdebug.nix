{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  riptide-cli,
  click,
}:

buildPythonPackage rec {
  pname = "riptide-plugin-php-xdebug";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-plugin-php-xdebug.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "0ab51aa45f44728c6a420ea8ba1eef4a4cb89a0c";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    riptide-cli
    click
  ];

  doCheck = false;
  pythonImportsCheck = [ "riptide_plugin_php_xdebug" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-plugin-php-xdebug";
    description = "Tool to manage development environments for web applications using containers - Plugin to toggle PHP Xdebug";
    license = licenses.mit;
  };
}
