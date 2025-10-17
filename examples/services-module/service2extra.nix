{
  pkgs,
  lib,
  config,
  ...
}:
{
  environment.systemPackages = [ pkgs.curl ];
}
