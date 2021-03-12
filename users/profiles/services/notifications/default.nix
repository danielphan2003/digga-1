{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "hicolor";
      package = pkgs.hicolor_icon_theme;
      size = "32x32";
    };
    settings = {
      global = {
	frame_color = "#d5c4a1";
	allow_markup = "yes";
    	format = "%s\n%b";
    	sort = "yes";
    	indicate_hidden = "yes";
    	alignment = "left";
    	bounce_freq = "0";
    	show_age_threshold = "60";
    	word_wrap = "yes";
    	ignore_newline = "no";
    	geometry = "430-10+48";
    	transparency = "25";
    	idle_threshold = "120";
    	monitor = "0";
    	follow = "mouse";
    	sticky_history = "yes";
    	line_height = "5";
    	separator_height = "0";
    	padding = "10";
    	horizontal_padding = "10";
    	separator_color = "#bfbfbf";
    	startup_notification = "false";
    	show_indicators = "no";
    	dmenu = "dmenu -p dunst";
    	browser = "brave -new-tab";
    	icon_position = "left";
      };

      frame = {
	color = "ffffff";
	width = "0";
      };
      
      base16_low = {
        msg_urgency = "low";
        background = "#3c3836";
        foreground = "#665c54";
      };
      
      base16_normal = {
        msg_urgency = "normal";
        background = "#504945";
        foreground = "#d5c4a1";
      };
      
      base16_critical = {
        msg_urgency = "critical";
        background = "#fb4934";
        foreground = "#ebdbb2";
      };
    };
  };
}

