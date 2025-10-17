# usage: simple-service { serviceName = "myService"; description = "My Service"; } ./someModule.nix
# will be enabled by default, also has option to disable it.
{
  serviceName,
  description,
}:
service:
{
  pkgs,
  lib,
  config,
  ...
}@input:
{
  options = {
    ${serviceName}.enable = (lib.mkEnableOption description) // {
      default = true;
    };
  };
  config = {
    imports = [ (lib.mkIf config.${serviceName}.enable service) ];
  };
}
