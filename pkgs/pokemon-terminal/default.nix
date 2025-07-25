{
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "pokemon-terminal";
  version = "1.3.0";
  src = fetchFromGitHub {
    owner = "LazoCoder";
    repo = "Pokemon-Terminal";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-r2BfKh87LnkT3xL1qnJA8f88wB/gH4rr4ZlvYqiX/K8=";
  };
  pyproject = true;
  build-system = [python3.pkgs.setuptools];
  propagatedBuildInputs = with python3.pkgs; [
    psutil
    pytest
  ];
  postInstall = ''
    # Add support for swww
    # ln -sT $\{./swww.py} $out/lib/python3.10/site-packages/pokemonterminal/wallpaper/adapters/swww.py
  '';
  meta = with lib; {
    description = "Pokemon terminal themes.";
    homepage = https://github.com/LazoCoder/Pokemon-Terminal;
    changelog = "https://github.com/LazoCoder/Pokemon-Terminal/releases";
    license = licenses.gpl3;
    platforms = platforms.all;
    mainProgram = "pokemon";
  };
}
