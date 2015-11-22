# Sets the neo layout both for the X Server and the vty.
{ pkgs, ... }:
let console-neo-map = pkgs.fetchsvn {
  url = "https://svn.neo-layout.org/linux/console/neo.map";
  sha256 = "18r2213mh1a9xhhkrlfj9mrw0b8gziz58mc6g24bk4kdfw49nzzg";
  name = "console-neo.map";
};
in
{
  services.xserver.layout = "de";
  services.xserver.xkbVariant = "neo";

  i18n.consoleKeyMap = "${console-neo-map}";
}
