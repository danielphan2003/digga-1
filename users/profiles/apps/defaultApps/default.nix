{ config, ... }:

{
  
  xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "okularApplication_pdf.desktop";
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "org.onlyoffice.desktopeditors.desktop";
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "org.onlyoffice.desktopeditors.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "org.onlyoffice.desktopeditors.desktop";
        "image/gif" = "gimp.desktop";
        "image/jpeg" = "gimp.desktop";
        "image/png" = "gimp.desktop";
        "text/html" = "brave-browser.desktop";
        "x-scheme-handler/discord-398246104468291591" = "discord-398246104468291591.desktop";
        "x-scheme-handler/discord-610508934456934412" = "discord-610508934456934412.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/mailto" = "userapp-Evolution-CZZM2Z.desktop";
        "x-scheme-handler/sgnl" = "signal-desktop.desktop";
        "x-scheme-handler/slack" = "slack.desktop";
        "x-scheme-handler/webcal" = "brave-browser.desktop";
      };
    };
  
}
