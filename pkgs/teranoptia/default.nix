{
  lib,
  stdenv,
  fetchFromGitLab,
}:
stdenv.mkDerivation rec {
  pname = "teranoptia";
  version = "unstable-2021-12-21";

  src = fetchFromGitLab {
    owner = "arielmartinperez";
    repo = "teranoptia";
    rev = "607516ba48af17667e1fb811da547d255f48ff3e";
    hash = "sha256-kvjsf8Y98Fx5SPAQ2i/vJoSlJJLqcgt3pJHc8MkrG14=";
  };

  installPhase = ''
    cd fonts
    find . -name '*.ttf'    -exec install -Dt $out/share/fonts/truetype {} \;
    find . -name '*.otf'    -exec install -Dt $out/share/fonts/opentype {} \;
    find . -name '*.woff'  -exec install -Dt $out/share/fonts/woff {} \;
    find . -name '*.woff2'  -exec install -Dt $out/share/fonts/woff2 {} \;
  '';

  meta = with lib; {
    description = "Teranoptia is an illustrative font which allows you to create chimeric creatures";
    homepage = "https://gitlab.com/arielmartinperez/teranoptia/";
    license = licenses.ofl;
    maintainers = with maintainers; [];
    mainProgram = "teranoptia";
    platforms = platforms.all;
  };
}
