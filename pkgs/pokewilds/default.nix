{
  lib,
  stdenv,
  unzip,
  jre,
  systemd,
  pkg-config,
  udev,
  makeWrapper,
  # libudev0-shim,
}:
stdenv.mkDerivation rec {
  pname = "pokewilds";
  version = "0.8.11";

  src = builtins.fetchurl {
    url = "https://github.com/SheerSt/pokewilds/releases/download/v${version}/pokewilds-otherplatforms.zip";
    sha256 = "sha256:1fi2zdr6mi91f4m8d46pb6822iglzb7b4fkzb3nv9rky8izwl2jw";
  };
  nativeBuildInputs = [unzip makeWrapper pkg-config udev];
  buildInputs = [systemd];
  propagatedBuildInputs = [jre udev];
  buildPhase = "";
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib/linux-x86-64
    ln -s ${udev}/lib/libudev.so $out/lib/linux-x86-64/libudev.so
    cp -r mods $out/bin
    cp pokewilds.jar $out/bin
    makeWrapper ${jre}/bin/java $out/bin/pokewilds\
      --add-flags "-Djava.library.path=$out/lib -jar $out/bin/pokewilds.jar"\
      --set LD_PRELOAD "${udev}/lib/libudev.so"
  '';

  meta = with lib; {
    description = "PokeWilds - A Gen 2 Game/Engine using libGDX";
    homepage = "https://github.com/SheerSt/pokewilds/releases/latest/download/pokewilds-linux64.zip";
    license = with licenses; [];
    maintainers = with maintainers; [];
    broken = true;
    # mainProgram = "PokeWilds-x64";
  };
}
