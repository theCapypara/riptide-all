{
  lib,
  cfg,
  pkgs,
}:
pkgs.symlinkJoin {
  name = "riptide-wrap";
  paths = [
    (pkgs.python3.withPackages (
      _:
      [
        cfg.cli.package
        cfg.engine.package
      ]
      ++ (lib.optionals cfg.dbDrivers.mysql.enable [ cfg.dbDrivers.mysql.package ])
      ++ (lib.optionals cfg.dbDrivers.mongodb.enable [ cfg.dbDrivers.mongodb.package ])
      ++ (lib.optionals cfg.plugins.phpXdebug.enable [ cfg.plugins.phpXdebug.package ])
      ++ (lib.optionals cfg.proxy.enable [ cfg.proxy.package ])
    ))
  ];
  nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
  postBuild = ''
    wrapProgram $out/bin/riptide --set DOCKER_HOST ${lib.escapeShellArg cfg.dockerHost} --set RIPTIDE_SHELL_INTEGRATION_EXECUTABLE /run/current-system/sw/bin/_riptide-python
    wrapProgram $out/bin/riptide_proxy --set DOCKER_HOST ${lib.escapeShellArg cfg.dockerHost} --set RIPTIDE_SHELL_INTEGRATION_EXECUTABLE /run/current-system/sw/bin/_riptide-python
    # Expose a riptide-python to be used for shell integration, see also env variable used above.
    cp $out/bin/python3 $out/bin/_riptide-python
  '';
}
