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
    rev = "244bdb46112830caa3d3ca5fd13f4a0bb281e993";
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
