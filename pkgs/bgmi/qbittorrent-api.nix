{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "qbittorrent-api";
  version = "2023.6.49";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-GQ+1BOw26YoZGhy46CZbZEecBHgZ4RISESJi0fze6bI=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    enum34
    requests
    setuptools
    six
    urllib3
    backports_functools_lru_cache
  ];

  passthru.optional-dependencies = with python3.pkgs; {
    dev = [
      black
      build
      coverage
      furo
      mock
      mypy
      pre-commit
      pytest
      sphinx
      sphinx-copybutton
      sphinxcontrib-spelling
      tox
      twine
      types-requests
      types-six
    ];
  };

  pythonImportsCheck = ["qbittorrentapi"];

  meta = with lib; {
    description = "Python client for qBittorrent v4.1+ Web API";
    homepage = "https://pypi.org/project/qbittorrent-api/";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
