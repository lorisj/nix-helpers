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
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.x86_64-linux = nix-helpers.lib.devshells-wrapper { inherit pkgs; } {
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
