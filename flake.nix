{
  description = "Utilities for Nix";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { }:
    {
      overlays = {
        devshell-override = import ./lib/devshell-override.nix;
      };
    };
}
