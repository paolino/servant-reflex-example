{ mkDerivation, base, servant, stdenv }:
mkDerivation {
  pname = "common";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ base servant ];
  license = stdenv.lib.licenses.unfree;
}
