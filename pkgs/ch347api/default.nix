{
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "ch347-hidapi";
  version = "unstable-2023-08-06";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "i2cy";
    repo = "CH347-HIDAPI";
    rev = "7dee10c";
    hash = "sha256-wwdxn8cxF+1shtDHT0EeZxcvnQe1y0btoyFk4wDpHlM=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    hidapi
  ];

  pythonImportsCheck = ["ch347api"];

  meta = with lib; {
    description = "A Python Library provides full access of SPI/I2C settings and communication with CH347 USB-SPI/I2C bridge chip in Python language";
    homepage = "https://github.com/i2cy/CH347-HIDAPI";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
