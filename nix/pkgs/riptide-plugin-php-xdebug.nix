{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  riptide-cli,
  click,
  rich,
}:

buildPythonPackage {
  pname = "riptide-plugin-php-xdebug";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-plugin-php-xdebug.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "d6b2bd923a88a04fce3c2d1ded5f4945edc896e4";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    riptide-cli
    click
    rich
  ];

  doCheck = false;
  pythonImportsCheck = [ "riptide_plugin_php_xdebug" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-plugin-php-xdebug";
    description = "Tool to manage development environments for web applications using containers - Plugin to toggle PHP Xdebug";
    license = licenses.mit;
  };
}
