{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "shox";
  version = "0.0.19";

  src = fetchFromGitHub {
    owner = "liamg";
    repo = "shox";
    rev = "v${version}";
    hash = "sha256-inkBYnYBVWbyBreiS2Rf7Hv3WmmH4jYUPr1A8FeSlZ8=";
  };

  vendorHash = null;

  ldflags = ["-s" "-w"];

  meta = with lib; {
    description = "A customisable, universally compatible terminal status bar";
    homepage = "https://github.com/liamg/shox";
    license = licenses.unlicense;
    # broken = true;
    maintainers = with maintainers; [];
  };
}
