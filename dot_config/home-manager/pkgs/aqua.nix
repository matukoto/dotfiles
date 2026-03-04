{ pkgs }:

let
  version = "2.56.7";

  target =
    if pkgs.stdenv.isDarwin then
      {
        suffix = "darwin_arm64";
        sha256 = "8d6b37e86448debc0dfabf3b103f11bea8d7ad9b0c0b9bb3163b6075bbd87aba";
      }
    else
      {
        suffix = "linux_amd64";
        sha256 = "28c66335265451ac0d34a364e57836e6d73ef55cbb9698265ce3ee2b97f1c7c0";
      };
in
pkgs.stdenv.mkDerivation {
  pname = "aqua";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/aquaproj/aqua/releases/download/v${version}/aqua_${target.suffix}.tar.gz";
    sha256 = target.sha256;
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp -r aqua $out/bin/
    chmod +x $out/bin/aqua
  '';

  meta = {
    description = "Declarative CLI Version manager written in Go.";
    homepage = "https://github.com/aquaproj/aqua";
    license = pkgs.lib.licenses.mit;
  };
}
