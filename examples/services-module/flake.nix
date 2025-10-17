{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = pkgs.lib;
      servicesModule = import ../../lib/services-module.nix;
      serviceMap = {
        service1 = [ ./service1.nix ];
        service2 = [
          ./service2base.nix
          ./service2extra.nix
        ];
      };
    in
    {
      demo = servicesModule {
        inherit serviceMap;
        optionName = "demoOptionName";
        description = "demo description";
      };
    };
}
