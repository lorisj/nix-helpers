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
        map-keys = import ./lib/map-keys.nix;
        find-nix-files = import ./lib/find-nix-files.nix;
        find-all-files-by-name = import ./lib/find-all-files-by-name.nix;
        replace-by-set = import ./lib/replace-by-set.nix;
      };
    };
}
