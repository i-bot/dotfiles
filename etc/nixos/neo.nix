# Sets the neo layout both for the X Server and the vty.
{ pkgs, ... }:
let console-neo-map = pkgs.fetchsvn {
  url = "https://svn.neo-layout.org/linux/console/neo.map";
  sha256 = "1v681p1q8nnvwv8wkqk6d1vyyqjxc365w2jxfpdk1szf5v23d3jr";
  name = "console-neo.map";
};
in
{
  services.xserver.layout = "de";
  services.xserver.xkbVariant = "neo";

  i18n.consoleKeyMap = "${console-neo-map}";
}
