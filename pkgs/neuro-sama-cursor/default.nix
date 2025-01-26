{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  inkscape,
  xcursorgen,
}:
stdenvNoCC.mkDerivation rec {
  pname = "neuro-sama-cursor";
  version = "1.0";

  src = ./Neuro-sama.tar.gz;

  nativeBuildInputs = [
    # inkscape
    # xcursorgen
  ];

  installPhase = ''
    mkdir -p $out/share/icons
    cp cursors/* $out/share/icons/
  '';

  meta = with lib; {
    description = "Numix cursor theme";
    homepage = "https://numixproject.github.io";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [offline];
  };
}
