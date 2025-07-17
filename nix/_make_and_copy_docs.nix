{
  nixpkgs ? <nixpkgs>,
  system ? builtins.currentSystem,
  ...
}:
let
  pkgs = import nixpkgs {
    inherit system;
    overlays = [ (import ./overlay.nix) ];
  };

  eval = pkgs.lib.evalModules {
    modules = [
      { options = (import ./modules/options.nix) { inherit (pkgs) formats lib; }; }
      { options._module.args = pkgs.lib.mkOption { internal = true; }; }
    ];
  };
  # generate docs
  optionsDoc = pkgs.nixosOptionsDoc { inherit (eval) options; };
in
# output option docs
pkgs.runCommand "_nix_module_cfg.md" { } ''
  cat ${optionsDoc.optionsCommonMark} >> $out
''
