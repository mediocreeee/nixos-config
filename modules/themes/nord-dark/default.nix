# modules/themes/nord-dark/default.nix

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.theme;
in {
  config = mkIf (cfg.active == "nord-dark") (mkMerge [
    # Desktop-agnostic configuration
    {
      modules = {
        theme = {
          wallpaper = mkDefault ./config/wallpaper.png;
          gtk = {
            theme = "Nordic";
            iconTheme = "Arc";
            cursorTheme = "Breeze";
          };
        };

        shell.zsh.rcFiles = [ ./config/zsh/prompt.zsh ];
        # shell.tmux.rcFiles = [ ./config/tmux.conf ];
        desktop.browsers = {
          firefox.userChrome = concatMapStringsSep "\n" readFile
            [ ./config/firefox/userChrome.css ];
          # qutebrowser.userStyles = concatMapStringsSep "\n" readFile
          #   (map toCSSFile [
          #     ./config/qutebrowser/userstyles/monospace-textareas.scss
          #     ./config/qutebrowser/userstyles/stackoverflow.scss
          #     ./config/qutebrowser/userstyles/xkcd.scss
          #   ]);
        };
      };
    }

    # Desktop (X11) theming
    (mkIf config.services.xserver.enable {
      user.packages = with pkgs; [ nordic breeze-gtk arc-icon-theme ];
      fonts = {
        fonts = with pkgs; [
          fira-code
          fira-code-symbols
          ibm-plex
          hack-font
          font-awesome-ttf
        ];
        fontconfig.defaultFonts = {
          # sansSerif = [ "IBM Plex Mono" ];
          # monospace = [ "IBM Plex Mono" ];
          sansSerif = [ "Hack" ];
          monospace = [ "Hack" ];
        };
      };

      # Compositor
      services.picom = {
        fade = true;
        fadeDelta = 1;
        fadeSteps = [ 1.0e-2 1.2e-2 ];
        shadow = true;
        shadowOffsets = [ (-10) (-10) ];
        shadowOpacity = 0.22;
        activeOpacity = 1.0;
        inactiveOpacity = 0.8;
        settings = {
          shadow-radius = 12;
          # blur-background = true;
          # blur-background-frame = true;
          # blur-background-fixed = true;
          blur-kern = "7x7box";
          blur-strength = 320;
        };
      };

      env = { THEME = "nord-dark"; };

      # Login screen theme
      services.xserver.displayManager.lightdm.greeters.mini.extraConfig = ''
        text-color = "#eceff4"
        password-color = "#eceff4"
        password-background-color = "#4c566a"
        window-color = "#3b4252"
        border-color = "#3b4252"
        error-color = "#bf616a"
      '';

      # Other dotfiles
      home.configFile = with config.modules;
        mkMerge [
          {
            # Sourced from sessionCommands in modules/themes/default.nix
            # "xtheme/90-theme".source = ./config/Xresources;
          }
          (mkIf desktop.awesome.enable {
            "awesome/themes/current-theme".source =
              ./config/awesome/themes/current-theme;
          })

          (mkIf desktop.term.alacritty.enable {
            "alacritty/current-theme.yml".source =
              ./config/alacritty/current-theme.yml;
          })

          (mkIf editors.emacs.enable {
            "doom/current-theme.el".source = ./config/emacs/current-theme.el;
          })

          (mkIf editors.vim.enable {
            "vim/current-theme.vim".source = ./config/vim/current-theme.vim;
          })

          # (mkIf desktop.apps.rofi.enable {
          #   "rofi/theme" = {
          #     source = ./config/rofi;
          #     recursive = true;
          #   };
          # })
          # (mkIf (desktop.bspwm.enable || desktop.stumpwm.enable) {
          #   "polybar" = {
          #     source = ./config/polybar;
          #     recursive = true;
          #   };
          #   "dunst/dunstrc".source = ./config/dunstrc;
          # })
          (mkIf desktop.media.graphics.vector.enable {
            "inkscape/templates/default.svg".source =
              ./config/inkscape/default-template.svg;
          })
          # (mkIf desktop.browsers.qutebrowser.enable {
          #   "qutebrowser/extra/theme.py".source = ./config/qutebrowser/theme.py;
          # })
        ];
    })
  ]);
}
