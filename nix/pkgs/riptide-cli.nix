{
  lib,
  buildPythonPackage,

  riptide-lib,
  click,
  colorama,
  click-help-colors,
  tqdm,
  packaging,
}:

buildPythonPackage {
  pname = "riptide-cli";
  version = "0.8.3";

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-cli.git";
    ref = "refs/tags/0.8.3";
    rev = "c25a510813b1b2a028ab99e4f9f79bc11501356c";
  };

  propagatedBuildInputs = [
    riptide-lib
    click
    colorama
    click-help-colors
    tqdm
    packaging
  ];

  # Call wrapping manually since we have some sourcable shell scripts that must not be wrapped, see below.
  dontWrapPythonPrograms = true;

  # Make the sourcable shell scripts non-executable before wrapping. That will skip them.
  postFixup = ''
    chmod -x $out/bin/riptide.hook.*
    wrapPythonPrograms
    chmod +x $out/bin/riptide.hook.*
  '';

  # Not supported on Nix. Wouldn't make sense anyway.
  postInstall = ''
    rm $out/bin/riptide_upgrade
  '';

  doCheck = false;
  pythonImportsCheck = [ "riptide_cli" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-cli";
    description = "Tool to manage development environments for web applications using containers - CLI-Application";
    license = licenses.mit;
    maintainers = with maintainers; [ theCapypara ];
    mainProgram = "riptide";
  };
}
