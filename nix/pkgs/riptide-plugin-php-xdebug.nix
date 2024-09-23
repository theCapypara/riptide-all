{
  lib,
  buildPythonPackage,

  riptide-lib,
  riptide-cli,
  click,
}:

buildPythonPackage {
  pname = "riptide-plugin-php-xdebug";
  version = "0.9.0";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-plugin-php-xdebug.git";
    #ref = "refs/tags/0.9.0";
    rev = "1696a7638c2e77ab6d4f717202b8f88b4280fefd";
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
