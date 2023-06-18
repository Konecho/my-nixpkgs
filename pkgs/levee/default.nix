{
  lib,
  stdenv,
  fetchFromSourcehut,
  zig,
  wayland,
  pkg-config,
  wayland-protocols,
  pulseaudio,
  pixman,
  udev,
  fcft,
}:
stdenv.mkDerivation rec {
  pname = "levee";
  version = "0.1.3";

  src = fetchFromSourcehut {
    owner = "~andreafeletto";
    repo = "levee";
    rev = "v${version}";
    hash = "sha256-jUF2clI1wbJbDGMoVHCS74c2jrZmf1BFe1L32ACbNGI=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [zig wayland pkg-config];
  buildInputs = [
    wayland-protocols
    pulseaudio
    pixman
    udev
    fcft
  ];

  preBuild = ''
    export HOME=$TMPDIR
  '';

  installPhase = ''
    runHook preInstall
    zig build --prefix $out install
    runHook postInstall
  '';

  meta = with lib; {
    description = "";
    homepage = "https://git.sr.ht/~andreafeletto/levee";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
