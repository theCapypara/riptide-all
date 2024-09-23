#!/usr/bin/env bash
set -xe
nix-build nix/_make_and_copy_docs.nix --out-link _nix_module_cfg.md.link
mkdir -p "$1"
cat _nix_module_cfg.md.link > "$1/_nix_module_cfg.md"
rm _nix_module_cfg.md.link
sed -i 's/##/\n###/g' "$1/_nix_module_cfg.md"