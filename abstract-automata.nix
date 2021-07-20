{ mkDerivation, ansi-terminal, base, stdenv }:
mkDerivation {
  pname = "abstract-automata";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ ansi-terminal base ];
  description = "Simulate Turing Machines";
  license = "GPL";
}
