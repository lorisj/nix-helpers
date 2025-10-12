{
  description = "Utilities for Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      lib = {
        devshells-wrapper = import ./lib/devshells-wrapper.nix;
      };
    };
}
