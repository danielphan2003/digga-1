{ config, pkgs, ... }:
let
  colors = {
    dark0_hard = "#1D2021";
    dark0 = "#282828";
    dark0_soft = "#32302F";
    dark1 = "#3c3836";
    dark2 = "#FF504945";
    dark3 = "#665c54";
    dark4 = "#7C6F64";
    
    gray_245 = "#928374";
    gray_246 = "#A89984";
    
    light0_hard = "#FB4934";
    light0 = "#FBF1C7";
    light0_soft = "#F2E5BC";
    light1 = "#EBDBB2";
    light2 = "#D5C4A1";
    light3 = "#BDAE93";
    light4 = "#A89984";
    
    bright_red = "#FB4934";
    bright_green = "#B8BB26";
    bright_yellow = "#FABD2F";
    bright_blue = "#83A598";
    bright_purple = "#D3869B";
    bright_aqua = "#8EC07C";
    bright_orange = "#FE8019";
    
    neutral_red = "#CC241D";
    neutral_green = "#98971A";
    neutral_yellow = "#D79921";
    neutral_blue = "#458588";
    neutral_purple = "#B16286";
    neutral_aqua = "#689D6A";
    neutral_orange = "#D65D0E";
    
    faded_red = "#9D0006";
    faded_green = "#79740E";
    faded_yellow = "#B57614";
    faded_blue = "#076678";
    faded_purple = "#8F3F71";
    faded_aqua = "#427B58";
    faded_orange = "#AF3A03";
  };

in
{

  xsession.windowManager.bspwm.startupPrograms = 
    [ "pkill polybar; ${pkgs.polybar}/bin/polybar top" ];

  services.polybar = {
    enable = true;
    # polybar-kdeconnect-script = pkgs.writeScript "polybar-kdeconnect-script" (builtins.readFile (pkgs.fetchurl {
    #   url = "https://raw.githubusercontent.com/HackeSta/polybar-kdeconnect/master/polybar-kdeconnect.sh";
    #   sha256 = "1zziixaw4hn6r272xvjn0yvbbf0nbakmwm90zfv7k62pfvzqcr9j";
    # }));
    config = {
      "bar/top" = {
        width = "100%";
        height = "4%";
	wm-restack = "bspwm";

        modules-left = "bspwm";
        modules-center = "date";
	modules-right = "network battery";

        tray-position = "right"; 
	tray-background = colors.dark2;
	tray-transparent = "false";

	#format-padding = "2";
	#format-background = colors.dark2;
        background = "00111111";
        foreground = colors.light1;
	line-size = "5";

	font-0 = "NotoSans:size=14";
	font-1 = "Monospace:size=14";
	font-2 = "NotoSansSymbols:size=14"; 
	font-3 = "FontAwesome5FreeSolid:size=12";
	font-4 = "FontAwesome5FreeRegular:size=12";
	font-5 = "Iosevka:size=14";
      };

      # Time/Date Module
      "module/date" = {
        type = "internal/date";
        date = "%y-%m-%d";
	time = "%R";
        label = "%date% %time%";
	format-background = colors.dark2;
	format-padding = "2";
	format-underline = colors.neutral_green;
      };

      # Workspaces(bspwm) Module      
      "module/bspwm" = {
        type = "internal/bspwm";
        enable-click = "true";

        label-focused = "%name%";
	label-focused-padding = "2";
	label-focused-background = colors.gray_246;
	label-focused-underline = colors.neutral_orange;
	
	label-occupied = "%name%";
	label-occupied-padding = "2";
	label-occupied-background = colors.gray_245;
	
	label-urgent = "%name%!";
	label-urgent-background = colors.bright_red;
	label-urgent-padding = "2";
	
	label-empty = "%name%";
	label-empty-background = colors.dark2;
	label-empty-padding = "2";
      };

      "module/battery" = {
	type = "internal/battery";

	battery = "BAT0";
	adapter = "AC0";

	format-charging = "<animation-charging> <label-charging>";
	format-charging-padding = "2";
	format-charging-background = colors.dark2;
	format-charging-underline = colors.neutral_red;
	label-charging = "%percentage%%";
      	label-full = " 100%";

	format-discharging = "<ramp-capacity> <label-discharging>";
	format-discharging-padding = "2";
	format-discharging-background = colors.dark2;
	format-discharging-underline = colors.neutral_red;
	label-discharging = "%percentage%%";

      	ramp-capacity-0 = "";
      	ramp-capacity-1 = "";
      	ramp-capacity-2 = "";
      	ramp-capacity-3 = "";
      	ramp-capacity-4 = "";
      	
      	animation-charging-0 = "";
      	animation-charging-1 = "";
      	animation-charging-2 = "";
      	animation-charging-3 = "";
      	animation-charging-4 = "";
      	animation-charging-framerate = "750";
      };

      "module/network" = {
	type = "internal/network";
	interface = "wlp1s0";

	format-connected = ": <ramp-signal> <label-connected>";
	format-connected-padding = "2";
	format-connected-background = colors.dark2;
	format-connected-underline = colors.neutral_blue;
	label-connected = "%essid%";

	format-disconnected = ":  <label-disconnected>";
	format-disconnected-padding = "2";
	format-disconnected-background = colors.dark2;
	format-disconnected-underline = colors.neutral_blue;
	label-disconnected = "Disconnected";

	format-packetloss = " <animation-packetloss> <label-connected> ";

	ramp-signal-0 = "";
	ramp-signal-1 = "";
	ramp-signal-2 = "";
	ramp-signal-3 = "";
	ramp-signal-4 = "";
	ramp-signal-5 = "";

	animation-packetloss-0 = "⚠";
	animation-packetloss-0-foreground = "#ffa64c";
	animation-packetloss-1 = "📶";
	animation-packetloss-1-foreground = "#000000";

	animation-packetloss-framerate = "500";
      };

      "module/kdeconnect" = {
	type = "custom/script";
	# exec = "${polybar-kdeconnect-script} -d";
	tail = "true";
	format-padding = "2";
	format-background = colors.dark2;
	format-underline = colors.neutral_aqua;
      };

    };
    script = "";
  };
}
