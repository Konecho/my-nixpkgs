{
  lib,
  stdenv,
  unzip,
  jre,
  udev,
  makeWrapper,
  # libudev0-shim,
}:
stdenv.mkDerivation rec {
  pname = "pokewilds";
  version = "0.8.9";

  src = builtins.fetchurl {
    url = "https://github.com/SheerSt/pokewilds/releases/download/v${version}/pokewilds-otherplatforms.zip";
    sha256 = "sha256:11yd2w29br9vr6kw175vflvj326pfy9g9drf7y51m65pr2525lfp";
  };
  nativeBuildInputs = [unzip makeWrapper];
  buildInputs = [jre udev];
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
    # mainProgram = "PokeWilds-x64";
  };
}
