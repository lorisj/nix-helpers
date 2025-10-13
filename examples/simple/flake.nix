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
      devshells-wrapper = nix-helpers.lib.devshells-wrapper;
    in
    {

      devShells.x86_64-linux = (
        (devshells-wrapper) {
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
        }
      );
    };
}
