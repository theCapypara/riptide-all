{
  pkgs,
  cfg,
  hostsFile,
  configDir,
  lib,
}:
let
  build-config = pkgs.stdenv.mkDerivation {
    name = "riptide-build-config";
    src = ./build-config.py;
    dontUnpack = true;

    nativeBuildInputs = [
      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pyyaml
        python-pkgs.mergedeep
      ]))
    ];

    buildPhase = ''
      runHook preBuild
      python3 \
        $src \
        ${lib.escapeShellArg (builtins.toJSON cfg)} \
        ${hostsFile} \
        ./config.yml
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      chmod 444 config.yml
      cp config.yml $out/config.yml
      runHook postInstall
    '';
  };
in
''
  mkdir -p '${configDir}'
  ln -sf '${build-config}/config.yml' '${configDir}/config.yml'
''
