{
  appimageTools,
  fetchzip,
}: let
  pname = "pokewilds";
  version = "0.8.11";
  extracted-zip = fetchzip {
    url = "https://github.com/SheerSt/pokewilds/releases/download/v0.8.11/pokewilds-linux64.zip";
    sha256 = "sha256-WFBxBmyldFuQxcwkqvsynNz4T61XF1TJI4jnRsGlwUA=";
  };
  src = "${extracted-zip}/PokeWilds-x64";
in
  appimageTools.wrapType2 {
    inherit version pname src;
  }
