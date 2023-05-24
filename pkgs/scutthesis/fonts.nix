{ lib
, stdenv
, fetchFromGitHub
, just
, texlive
}:

stdenv.mkDerivation
rec{
  src = fetchFromGitHub {
    owner = "mengchaoheng";
    repo = "SCUT_thesis";
    rev = "a225bf8fe35bf606ed718557eb199e43e47fd97b";
    hash = "sha256-GXZ/jaq8aSUAhn+p0yfs9wiCVq13Bx+GMJZvIVrc070=";
  };
  version = "unstable-2023-03-18";
  pname = "scutfonts";
  installPhase = ''
    find . -name '*.ttf'    -exec install -Dt $out/share/fonts/truetype {} \;
  '';
}
