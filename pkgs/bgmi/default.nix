{
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "bgmi";
  version = "4.4.6";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "BGmi";
    repo = "BGmi";
    rev = "v${version}";
    hash = "sha256-B4++aS4V3tOnI594HIsVQ/7XonRvXZoGicz45gECcOQ=";
  };

  nativeBuildInputs = with python3.pkgs; [
    poetry-core
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = true;

  # postPatch = ''
  #   substituteInPlace pyproject.toml --replace \
  #         "icalendar = '==5.0.7'" \
  #         'icalendar = "${python3.pkgs.icalendar.version}"'
  #   substituteInPlace pyproject.toml --replace \
  #         'tomlkit = "0.11.8"' \
  #         'tomlkit = "${python3.pkgs.tomlkit.version}"'
  #   substituteInPlace pyproject.toml --replace \
  #         "tornado = '==6.3.2'" \
  #         'tornado = "${python3.pkgs.tornado.version}"'
  #   substituteInPlace pyproject.toml --replace \
  #         '"==' \
  #         '"^'
  #   substituteInPlace pyproject.toml --replace \
  #         "'==" \
  #         "'^"
  # '';

  propagatedBuildInputs = with python3.pkgs; [
    beautifulsoup4
    click
    filetype
    icalendar
    (loguru.overrideAttrs (f: p: rec {
      version = "0.7.0";
      src = fetchPypi {
        pname = "loguru";
        inherit version;
        hash = "sha256-FhIFPO1q6E15Wd19XkMaBTJkIjfsIff9g6xz/lOeA+E=";
      };
    }))
    peewee
    pydantic
    requests
    semver
    (stevedore.overrideAttrs (f: p: rec {
      version = "5.1.0";
      src = fetchPypi {
        pname = "stevedore";
        inherit version;
        hash = "sha256-pUU0rPm4m8ftJkgHATtQW/B/dNvkvPo30yvQY4cLCHw=";
      };
    }))
    strenum
    tomlkit
    tornado
    transmission-rpc
    wcwidth
    (callPackage ./anime-episode-parser.nix {})
    (callPackage ./pycomplete.nix {})
    (callPackage ./qbittorrent-api.nix {})
    (callPackage ./strsimpy.nix {})
  ];

  pythonImportsCheck = ["bgmi"];

  meta = with lib; {
    description = "Looking for maintainers] BGmi is a cli tool with Web UI for subscribed bangumi";
    homepage = "https://github.com/BGmi/BGmi";
    license = licenses.mit;
    # broken = true;
    maintainers = with maintainers; [];
  };
}
