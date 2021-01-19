{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    aspellDicts.en
    aspell
  ];

  console = {
    keyMap = "us";
    font = "Lat2-Terminus15";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Denver";
}
