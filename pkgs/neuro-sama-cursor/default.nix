{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "neuro-sama-cursor";
  version = "1.0";

  src = ./Neuro-sama.tar.gz;

  installPhase = ''
    mkdir -p $out/share/icons/Neuro-sama
    mv ./* $out/share/icons/Neuro-sama
  '';

  meta = with lib; {
    description = "Neuro sama cursor";
    homepage = "https://store.kde.org/p/2163432";
    license = licenses.unlicense;
    platforms = platforms.all;
    maintainers = with maintainers; [offline];
  };
}
