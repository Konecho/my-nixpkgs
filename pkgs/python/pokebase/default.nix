{
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "pokebase";
  version = "1.3.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "PokeAPI";
    repo = "pokebase";
    rev = version;
    hash = "sha256-Pds+0p1+LqYxXBCtiXKUh0X5FeCco8QKkzZsryevHm0=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    requests
  ];
  doCheck = false;
  # pytestCheckPhase = "";
  # pythonImportsCheck = ["pokebase"];

  meta = with lib; {
    description = "Python 3 wrapper for Pokéapi v2";
    homepage = "https://github.com/PokeAPI/pokebase";
    license = licenses.bsd3;
    maintainers = [];
  };
}
