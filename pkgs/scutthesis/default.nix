{ lib
, stdenv
, fetchFromGitHub
, just
, texlive
}:
let
  # tex = (texlive.combine {
  #   inherit (texlive) scheme-small
  #     biber;
  #   # dvisvgm dvipng# for preview and export as html
  #   # wrapfig amsmath ulem hyperref capt-of;
  #   #(setq org-latex-compiler "lualatex")
  #   #(setq org-preview-latex-default-process 'dvisvgm)
  # });
  tex = texlive.combined.scheme-full;
  src = fetchFromGitHub {
    owner = "mengchaoheng";
    repo = "SCUT_thesis";
    rev = "a225bf8fe35bf606ed718557eb199e43e47fd97b";
    hash = "sha256-GXZ/jaq8aSUAhn+p0yfs9wiCVq13Bx+GMJZvIVrc070=";
  };
  version = "unstable-2023-03-18";
  font = stdenv.mkDerivation
    rec{
      pname = "scutfont";
      inherit src version;
      installPhase = ''
        find . -name '*.ttf'    -exec install -Dt $out/share/fonts/truetype {} \;
      '';
    };
in
stdenv.mkDerivation
rec {
  pname = "scutthesis";
  inherit src version;

  propagatedBuildInputs = [ just tex font ];
  binName = "scutthesis";

  installPhase = ''
    mkdir -p $out/bin
    cat ${./justfile}  >> $out/bin/${binName} 
    chmod +x $out/bin/${binName}
    substituteAllInPlace $out/bin/${binName}
    substituteInPlace $out/bin/${binName} --replace textlive  ${tex}/bin
  '';

  meta = with lib; {
    description = "华南理工大学硕博士学位论文LaTeX模板。Latex templates for the thesis of South China University of Technology";
    homepage = "https://github.com/mengchaoheng/SCUT_thesis";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
  };
}
