{ lib
, stdenv
, fetchFromGitHub
, fortune
}:

stdenv.mkDerivation rec {
  pname = "fortunes";
  version = "unstable-2021-08-13";

  src = fetchFromGitHub {
    owner = "ruanyf";
    repo = "fortunes";
    rev = "000fb01261e4d119e4e988ce82f49fb8b139fe3c";
    hash = "sha256-O258vnAHQ3RrJnMPmVntmkj+RSfpHsf/YKJcLZd0owc=";
  };

  buildInputs = [ fortune ];

  binName = "fortune-cn";

  # 目前只有<fortune-cn chinese>和<fortune-cn diet>能正常使用，不知道为什么

  buildPhase = ''
    mkdir -p $out/bin
    echo "#!/bin/bash" >> $out/bin/${binName} 
    echo "${fortune}/bin/fortune \$(echo \$@ | sed 's~\\b\\(fortunes\\|chinese\\|tang300\\|song100\\|diet\\)\\b~@out@/share/games/fortunes/\\1~g')">>$out/bin/${binName}
    chmod +x $out/bin/${binName}
    substituteAllInPlace $out/bin/${binName}
  '';

  installPhase = ''
    mkdir -p $out/share/games/fortunes
    cp data/* $out/share/games/fortunes
  '';

  meta = with lib; {
    description = "A collection of fortune database files for Chinese users";
    homepage = "https://github.com/ruanyf/fortunes";
    license = with licenses; [ ];
    maintainers = with maintainers; [ ];
    mainProgram = "${binName}";
  };
}
