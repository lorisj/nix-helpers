{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    example.service2BaseOption = lib.mkOption {
      type = lib.types.str;
      default = "base";
      description = "service2 base option";
    };
  };

  config = {
    environment.systemPackages = [ pkgs.git ];
  };
}
