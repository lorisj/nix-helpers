# wraps devShells, adds NIX_SHELL_NAME with name of shell
{
  pkgs,
}:
devShells:
let
  lib = pkgs.lib;
in
lib.mapAttrs (
  name: cfg:
  pkgs.mkShell (
    cfg
    // {
      env = (cfg.env or { }) // {
        NIX_SHELL_NAME = name;
      };
    }
  )
) devShells
