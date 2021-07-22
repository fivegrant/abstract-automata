{ mkDerivation, ansi-terminal, base, containers, lib }:
mkDerivation {
  pname = "abstract-automata";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ ansi-terminal base containers ];
  enableLibraryProfiling = true;
  enableExecutableProfiling = true;
  description = "Simulate automata";
  license = "GPL";
}
