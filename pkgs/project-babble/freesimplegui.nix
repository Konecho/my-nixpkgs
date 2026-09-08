{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "freesimplegui";
  version = "5.3.0.post1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-z8VxLGgDvfbwOqqhiwg6VKGj9CVCIa8Guwj6pKaqlxk=";
  };

  nativeBuildInputs = with python3.pkgs; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    tkinter
  ];

  pythonImportsCheck = ["FreeSimpleGUI"];

  meta = with lib; {
    description = "Free Python GUI - tkinter based";
    homepage = "https://github.com/spyoungtech/FreeSimpleGUI";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [];
  };
}
