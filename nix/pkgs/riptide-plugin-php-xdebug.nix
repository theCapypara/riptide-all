{
  lib,
  buildPythonPackage,

  riptide-lib,
  riptide-cli,
  click,
}:

buildPythonPackage {
  pname = "riptide-plugin-php-xdebug";
  version = "0.8.1";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-plugin-php-xdebug.git";
    ref = "refs/tags/0.8.1";
    rev = "ef9f3b6805602167cd7bcce59471d99f99ab889b";
  };

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
    maintainers = with maintainers; [ theCapypara ];
  };
}
