{ config, lib, pkgs, ... }:

{
  home.username = "abdulmujeeb";
  home.homeDirectory = "/home/abdulmujeeb";
  home.file.".config/hypr/lockscreen.png".source = ./wm/hewlett-packard.png;
  home.file.".config/hypr/wallpaper.png".source = ./wm/gruvbox-nix.png;
  
  home.pointerCursor = {
    enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    hyprcursor.enable = true;
    gtk.enable = true;
    dotIcons.enable = true;
  };
  
  home.packages = import ./pkgs.nix { inherit pkgs; };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox Dark";
    };
    iconTheme = {
      package = pkgs.gruvbox-dark-icons-gtk;
      name = "Gruvbox Dark";
    };
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };
    font = {
      name = "Noto Nerd Font";
      size = 12;
    };
  };
  
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
  
  programs.git = {
    enable = true;
    userName = "Abdulmujeeb Raji";
    userEmail = "abdul@midnadimple.com";
  };
  
  programs.starship = {
    enable = true;
    settings = {
    add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
  
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
    '';
    sessionVariables = {
      HYPRSHOT_DIR = "~/Pictures";
    }; 
    shellAliases = {};
  };
  
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 30;
      };
      background = [
        {
          path = "/home/abdulmujeeb/.config/hypr/lockscreen.png";
        }
      ];
      input-field = [
        {
          outer_color = "rgb(ebdbb2)";
          inner_color = "rgb(282828)";
          font_color = "rgb(ebdbb2)";
          fail_color = "rgb(cc241d)";
          position = "0, -300";
          size = "20%, 5%";
        }
      ];      
    };
  };

  services.hypridle =
  {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
      };
      
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
      ];
    };
  };
 
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [ "/home/abdulmujeeb/.config/hypr/wallpaper.png" ];
      wallpaper = [
        ",/home/abdulmujeeb/.config/hypr/wallpaper.png"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
      	position = "bottom";
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "network"
          "wireplumber"
          "cpu"
          "memory"
          "battery"
          "clock"
          "tray"
        ];
        network = {
          format-wifi = "{ifname} // {essid} ";
          format-ethernet = "{ifname} // {essid} 󰈀";
          format-disconnected = "{ifname} // {essid} 󰖪";
          on-click = "kitty nmtui";
        };
        wireplumber = {
          format = "{volume}%  ";
          format-muted = "Muted ";
          on-click = "pavucontrol";
        };
        cpu = {
          format = "{usage}% 󰻠";
          on-click = "kitty btop";
        };
        memory = {
          format = "{}% 󰍛";
          on-click = "kitty btop";
        };
        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        clock = {
          format = "{:%Y-%m-%d // %H:%M}  ";
          on-click = "obsidian";
        };
      }
    ];
    style = ''
* {
    font-family: Noto Nerd Font, sans-serif;
    font-size: 12px;
}
window#waybar {
    background-color: #ebdbb2;
    border-bottom: 2px solid #fbf1c7;
    color: #282828;
    transition-property: background-color;
    transition-duration: .2s;
    transition-property: color;
    transition-duration: .2s;
}

window#waybar.hidden {
    opacity: 0.2;
}

/*
window#waybar.empty {
    background-color: transparent;
}
window#waybar.solo {
    background-color: #FFFFFF;
}
*/

window#waybar.termite {
    background-color: #3F3F3F;
}

window#waybar.chromium {
    background-color: #000000;
    border: none;
}

button {
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
    /* Avoid rounded borders under each button name */
    border: none;
    border-radius: 0;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
    background: inherit;
    box-shadow: inset 0 -3px #ffffff;
}

/* you can set a style on hover for any module like this */
#workspaces button {
    padding: 0 5px;
    background-color: transparent;
    color: #282828;
}

#workspaces button:hover {
    background: #282828;
    color: #ebdbb2;
}

#workspaces button.focused {
    background-color: #3c3836;
    box-shadow: inset 0 -3px #ebdbb2;
}

#workspaces button.urgent {
    background-color: #fb4934;
}

#mode {
    background-color: #64727D;
    box-shadow: inset 0 -3px #ffffff;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#power-profiles-daemon,
#mpd {
    padding: 0 10px;
    color: #282828;
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    background-color: #3c3836;
    color: #ebdbb2;
}

#battery {
    background-color: #fe8019;
}

#battery.charging, #battery.plugged {
    background-color: #b8bb26;
}

@keyframes blink {
    to {
        background-color: #282828;
        color: #ebdbb2;
    }
}

/* Using steps() instead of linear as a timing function to limit cpu usage */
#battery.critical:not(.charging) {
    background-color: #fb4934;
    color: #282828;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: steps(12);
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

label:focus {
    background-color: #000000;
}

#cpu {
    background-color: #8ec07c;
}

#memory {
    background-color: #d3869b;
}

#network {
    background-color: #83a598;
}

#network.disconnected {
    background-color: #fb4934;
}

#wireplumber {
    background-color: #fabd2f;
    color: #282828;
}

#wireplumber.muted {
    background-color: #3c3836;
    color: #ebdbb2;
}

#tray {
    background-color: transparent;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
}

    '';
  };

  services.hyprpolkitagent.enable = true;

  services.mako = {
    enable = true;
    settings = {
      font = "Noto Nerd Font 12";
      background-color = "#282828FF";
      border-color = "#EBDBB2FF";
      border-radius = 12;
    };
  };
  
  services.network-manager-applet.enable = true;
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };

  programs.bemenu.enable = true;
  
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    font = {
      name = "Noto Nerd Font";
      size = 12;
    };
  };

  programs.chromium.enable = true;
  programs.firefox.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      general = {
        "col.inactive_border" = "rgb(282828)";
        "col.active_border" = "rgb(ebdbb2)";
      };
      xwayland = {
        force_zero_scaling = true;
      };
      monitor = [
        ", preferred, auto, 1"
      ];
      input = {
        kb_layout = "gb";
        kb_options = "ctrl:nocaps";
        touchpad = {
          natural_scroll = true;
        };
      };
      gestures = {
        workspace_swipe = true;
      };
      misc = {
        enable_swallow = true;
      };
      exec-once = [
        "waybar"
        "hyprctl setcursor 'DMZ (Black)' 24"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
      "$terminal" = "kitty";
      "$runmenu" = "bemenu-run -b -H 24 --fn 'Noto Nerd Font 12' --tf '##d79921' --nf '##ebdbb2' --sf '##d79921' --af '##bdae93' --hf '##d79921'";
      "$mainmod" = "SUPER";
      bind = [
        "$mainmod, T, exec, $terminal"
        "$mainmod, Q, killactive"
        "$mainmod, R, exec, $runmenu"
        "$mainmod, L, exec, hyprlock"

        "$mainmod SHIFT, Escape, exit"
        "$mainmod SHIFT, F, togglefloating"
        "$mainmod, left, movefocus, l"
        "$mainmod, right, movefocus, r"
        "$mainmod, up, movefocus, u"
        "$mainmod, down, movefocus, d"

        "$mainmod, 1, workspace, 1"
        "$mainmod, 2, workspace, 2"
        "$mainmod, 3, workspace, 3"
        "$mainmod, 4, workspace, 4"
        "$mainmod, 5, workspace, 5"
        "$mainmod, 6, workspace, 6"
        "$mainmod, 7, workspace, 7"
        "$mainmod, 8, workspace, 8"
        "$mainmod, 9, workspace, 9"
        "$mainmod, 0, workspace, 10"

        "$mainmod SHIFT, 1, movetoworkspace, 1"
        "$mainmod SHIFT, 2, movetoworkspace, 2"
        "$mainmod SHIFT, 3, movetoworkspace, 3"
        "$mainmod SHIFT, 4, movetoworkspace, 4"
        "$mainmod SHIFT, 5, movetoworkspace, 5"
        "$mainmod SHIFT, 6, movetoworkspace, 6"
        "$mainmod SHIFT, 7, movetoworkspace, 7"
        "$mainmod SHIFT, 8, movetoworkspace, 8"
        "$mainmod SHIFT, 9, movetoworkspace, 9"
        "$mainmod SHIFT, 0, movetoworkspace, 10"
        
        "$mainmod, mouse_down, workspace, e+1"
        "$mainmod, mouse_up, workspace, e-1"
        
        ", PRINT, exec, hyprshot -m output"
        "$mainmod, PRINT, exec, hyprshot -m window"
        "$mainmod SHIFT, PRINT, exec, hyprshot -m region"
      ];
      bindm = [
        "$mainmod, mouse:272, movewindow"
        "$mainmod, mouse:273, resizewindow"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        # TODO add brightnessctl controls
      ];
    };
  };

  programs.vim = {
    enable = true;
    settings = {
      expandtab = true;
      copyindent = true;
      tabstop = 4;
      shiftwidth = 4;
      background = "dark";
    };
  };

  services.trayscale.enable = true;

  services.syncthing = {
    enable = true;
    overrideDevices = false;
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  home.stateVersion = "25.05";
  
  programs.home-manager.enable = true;
}
