# display.nix

{
  pkgs,
  lib,
  config,
  ...
}:
let
  gnomeModule = import ./gnome.nix;
in
{
  options = something; # somehow forward suboptions from gnome s.t. I can do display.gnome.enable = true;
  config = {
    imports = [ gnomeModule ];
  };
}
