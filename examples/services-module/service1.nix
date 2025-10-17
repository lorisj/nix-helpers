{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    example.service1Enabled = lib.mkEnableOption "Enable service1";
  };

  config = lib.mkIf config.example.service1Enabled {
    environment.systemPackages = [ pkgs.hello ];
  };
}
