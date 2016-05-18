{ mkDerivation, base, common, servant, servant-server, stdenv, wai
, warp
}:
mkDerivation {
  pname = "server";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base common servant servant-server wai warp
  ];
  license = stdenv.lib.licenses.unfree;
}
