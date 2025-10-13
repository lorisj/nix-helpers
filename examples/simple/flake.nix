{
  description = "simple example";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-helpers.url = "github:lorisj/nix-helpers?ref=main";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-helpers,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-helpers.overlays.devshell-override ];
      };
      lib = pkgs.lib;
    in
    {

      devShells.${system} = pkgs.mkShellsWithName {
        shell1 = {
          packages = [ pkgs.hello ];
          shellHook = ''
            echo $NIX_SHELL_NAME
          '';
        };
        shell2 = {
          packages = [ pkgs.hello ];
          shellHook = ''
            echo $NIX_SHELL_NAME
          '';
        };
      };
    };
}
