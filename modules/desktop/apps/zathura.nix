{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.zathura;
in {
  options.modules.desktop.apps.zathura = { enable = mkEnableOption false; };

  config = mkIf cfg.enable { user.packages = with pkgs; [ zathura ]; };
}
