# wraps devShells, adds NIX_SHELL_NAME with name of shell
{
  pkgs,
  mkShell ? pkgs.mkShell,
  ...
}:
devShells:
let
  lib = pkgs.lib;
in
lib.mapAttrs (
  name: cfg:
  mkShell (
    cfg
    // {
      env = (cfg.env or { }) // {
        NIX_SHELL_NAME = name;
      };
    }
  )
) devShells
