with import <nixpkgs> {};

let
  config = {
    packageOverrides = pkgs: rec{
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          abstract-automata = haskellPackages.callPackage ./abstract-automata.nix {};
	};
      };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };
in 
{
  abstract-automata = pkgs.haskellPackages.abstract-automata;
}
