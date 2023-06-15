{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "anime-episode-parser";
  version = "0.0.12";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-JcK45AP2DbRuIwCY9cuRlzi6g9MbjwTJWGSk+ZaD1/M=";
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
