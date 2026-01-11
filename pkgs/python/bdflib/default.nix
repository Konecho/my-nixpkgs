{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "bdflib";
  version = "2.1.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-brf+Dm9rBrQaebGUVY8H6IEpm1SMZ0i1PsNX9RRX8u4=";
  };

  nativeBuildInputs = with python3.pkgs; [
    setuptools
    wheel
  ];

  pythonImportsCheck = [
    "bdflib"
  ];

  meta = {
    description = "Library for working with BDF font files";
    homepage = "https://pypi.org/project/bdflib/";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
  };
}
