with import <nixpkgs> {};

pkgs.mkShell rec {
 buildInputs = [
    (import ./abstract-automata.nix { inherit pkgs; })
    pkgs.ghc
  ];
 shellHook = ''
  export NIX_GHC="$(which ghc)"
  export NIX_GHCPKG="$(which ghc-pkg)"
  export NIX_GHC_DOCDIR="$NIX_GHC/../../share/doc/ghc/html"
  export NIX_GHC_LIBDIR="$(ghc --print-libdir)"
 '';
}

