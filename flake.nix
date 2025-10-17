{
  description = "Utilities for Nix";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, ... }:
    {
      overlays = {
        devshell-override = import ./lib/devshell-override.nix;
      };
      lib = {
        find-folders-with-filename = import ./lib/find-folders-with-filename.nix;
        map-keys = import ./lib/map-keys.nix;
        module-list = import ./lib/module-list.nix;
        add-namespace-to-module = import ./lib/add-namespace-to-module.nix;
      };
    };
}
