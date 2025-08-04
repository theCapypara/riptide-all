{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  riptide-cli,
  click,
}:

buildPythonPackage {
  pname = "riptide-plugin-php-xdebug";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-plugin-php-xdebug.git";
    # TODO
    #ref = "refs/tags/${version}";
    ref = "refs/heads/add-linting";
    rev = "e8aee7121b79984b25fa50ef0cd028293a8c8907";
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
