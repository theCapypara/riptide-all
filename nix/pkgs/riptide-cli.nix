{
  lib,
  buildPythonPackage,
  setuptools,

  riptide-lib,
  click,
  colorama,
  click-help-colors,
  tqdm,
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
    rev = "ea950801de58f8478e5b684f69749b80c6ea1ee1";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    riptide-lib
    click
    colorama
    click-help-colors
    tqdm
    packaging
  ];

  doCheck = false;

  # Not supported on Nix. Wouldn't make sense anyway.
  postInstall = ''
    rm $out/bin/riptide_upgrade
  '';

  # Remove the original hook scripts, since they will be wrapped by python.buildEnv. Instead
  # provide nix-riptide.hook.* variants that echo out the hooks when executed.
  postFixup = ''
    COMMON_HOOK_SRC=$(cat $out/bin/riptide.hook.common.sh)
    BASH_HOOK_SRC="$COMMON_HOOK_SRC $(cat $out/bin/riptide.hook.bash | grep -v 'riptide.hook.common.sh')"
    ZSH_HOOK_SRC="$COMMON_HOOK_SRC $(cat $out/bin/riptide.hook.zsh | grep -v 'riptide.hook.common.sh')"

    echo '#!/usr/bin/env bash' > $out/bin/nix-riptide.hook.bash
    printf 'cat <<'"'"'EOF'"'" >> $out/bin/nix-riptide.hook.bash
    echo ' '>> $out/bin/nix-riptide.hook.bash
    echo "$BASH_HOOK_SRC">> $out/bin/nix-riptide.hook.bash
    echo 'EOF' >> $out/bin/nix-riptide.hook.bash
    chmod +x $out/bin/nix-riptide.hook.bash

    echo '#!/usr/bin/env bash' > $out/bin/nix-riptide.hook.zsh
    printf 'cat <<'"'"'EOF'"'" >> $out/bin/nix-riptide.hook.zsh
    echo ' '>> $out/bin/nix-riptide.hook.zsh
    echo "$ZSH_HOOK_SRC">> $out/bin/nix-riptide.hook.zsh
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
