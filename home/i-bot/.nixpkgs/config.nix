# ~/.nixpkgs/config.nix

{
  packageOverrides = pkgs: with pkgs; {
    i-bot = buildEnv {
      name = "i-bot";
      paths = [
        eclipses.eclipse_sdk_442
        openjdk8
        go
        texLiveFull
        haskellPackages.cabal-install
        ./custom-pkgs/eclipse.nix
      ];
    };
  };
}
