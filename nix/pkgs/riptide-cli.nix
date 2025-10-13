{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  click,
  rich,
  click-help-colors,
  setproctitle,
  packaging,
}:

buildPythonPackage {
  pname = "riptide-cli";
  version = "0.10.0";
  pyproject = true;

  src = fetchGit {
    url = "https://github.com/theCapypara/riptide-cli.git";
    # TODO
    #ref = "refs/tags/${version}";
    rev = "d4240caedba0960292283c06a5684ded7ceabc54";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    click
    rich
    click-help-colors
    setproctitle
    packaging
  ];

  doCheck = false;

  # Not supported on Nix. Wouldn't make sense anyway.
  postInstall = ''
    rm $out/bin/riptide_upgrade
  '';

  # Remove the original hook scripts, since they will be wrapped by python.buildEnv. Instead
  # provide nix-riptide.hook.* variants that echo out the hooks when executed.
  # Also output the shell completion of Riptide
  postFixup = ''
    COMMON_HOOK_SRC=$(cat $out/bin/riptide.hook.common.sh)
    BASH_HOOK_SRC="$COMMON_HOOK_SRC $(cat $out/bin/riptide.hook.bash | grep -v 'riptide.hook.common.sh')"
    ZSH_HOOK_SRC="$COMMON_HOOK_SRC $(cat $out/bin/riptide.hook.zsh | grep -v 'riptide.hook.common.sh')"

    BASH_COMP_SRC=$(_RIPTIDE_COMPLETE=bash_source "$out/bin/riptide")
    ZSH_COMP_SRC=$(_RIPTIDE_COMPLETE=zsh_source "$out/bin/riptide")

    echo '#!/usr/bin/env bash' > $out/bin/nix-riptide.hook.bash
    printf 'cat <<'"'"'EOF'"'" >> $out/bin/nix-riptide.hook.bash
    echo ' '>> $out/bin/nix-riptide.hook.bash
    echo "$BASH_HOOK_SRC">> $out/bin/nix-riptide.hook.bash
    echo ' '  >> $out/bin/nix-riptide.hook.bash
    echo "$BASH_COMP_SRC">> $out/bin/nix-riptide.hook.bash
    echo 'EOF' >> $out/bin/nix-riptide.hook.bash
    chmod +x $out/bin/nix-riptide.hook.bash

    echo '#!/usr/bin/env bash' > $out/bin/nix-riptide.hook.zsh
    printf 'cat <<'"'"'EOF'"'" >> $out/bin/nix-riptide.hook.zsh
    echo ' '>> $out/bin/nix-riptide.hook.zsh
    echo "$ZSH_HOOK_SRC">> $out/bin/nix-riptide.hook.zsh
    echo ' '  >> $out/bin/nix-riptide.hook.zsh
    echo "$ZSH_COMP_SRC">> $out/bin/nix-riptide.hook.zsh
    echo 'EOF' >> $out/bin/nix-riptide.hook.zsh
    chmod +x $out/bin/nix-riptide.hook.zsh

    rm $out/bin/riptide.hook.*
  '';

  pythonImportsCheck = [ "riptide_cli" ];

  meta = with lib; {
    homepage = "https://github.com/theCapypara/riptide-cli";
    description = "Tool to manage development environments for web applications using containers - CLI-Application";
    license = licenses.mit;
    mainProgram = "riptide";
  };
}
