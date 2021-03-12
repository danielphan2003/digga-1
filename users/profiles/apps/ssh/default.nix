{ config, ... }:

{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 20;
    matchBlocks = {
      myrdd = {
        hostname = "myrdd.info";
        port = 4422;
      };
      anju = {
        hostname = "anjutech.com";
        port = 9812;
      };
      phone = {
        user = "alarm";
        hostname = "192.168.86.200";
        port = 22;
      };
    };
  };
}
