{
  lib,
  stdenv,
  fetchFromGitHub,
  zsh,
}:
stdenv.mkDerivation rec {
  pname = "arttime";
  version = "2.1.0";
  src = fetchFromGitHub {
    owner = "poetaman";
    repo = "arttime";
    rev = "v${version}";
    hash = "sha256-Ez7gQ7q5JwHUE+qoAkPdGGy+dDcRpaIwDHW+PYqrwXc=";
  };
  buildInputs = [zsh];
  installPhase = ''
    mkdir -p $out
    cp -r bin share $out
    patchShebangs $out/bin/*
    substituteInPlace $out/bin/arttime \
      --replace "exec zsh" "exec ${zsh}/bin/zsh"
  '';
  meta = with lib; {
    description = "Arttime is a terminal application that blends beauty of text-art with functionality of clock / timer / pattern-based time manager";
    homepage = "https://github.com/poetaman/arttime";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [];
  };
}
