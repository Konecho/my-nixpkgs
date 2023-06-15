{
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "anime-episode-parser";
  version = "0.0.12";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "BGmi";
    repo = "anime-episode-parser";
    rev = "v${version}";
    hash = "sha256-zfhEW9QzGtx7d0Oxx2d5oAG2NFIznpEQ2MkgqyFnLnM=";
  };

  nativeBuildInputs = [
    python3.pkgs.poetry-core
  ];

  pythonImportsCheck = ["anime_episode_parser"];

  meta = with lib; {
    description = "A library to parse episode info from anime title";
    homepage = "https://pypi.org/project/anime-episode-parser/";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
