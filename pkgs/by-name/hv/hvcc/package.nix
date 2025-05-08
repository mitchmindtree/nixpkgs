{
  lib,
  python3Packages,
  fetchFromGitHub,
  wstd2daisy,
}:

python3Packages.buildPythonApplication rec {
  pname = "hvcc";
  version = "0.13.4";

  src = fetchFromGitHub {
    owner = "Wasted-Audio";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-rUgKncHOvWYDjoqpB42xgb3Ccj0lUTghCDRA/RFJJeM=";
  };

  format = "pyproject";

  nativeBuildInputs = with python3Packages; [
    poetry-core
  ];

  propagatedBuildInputs = with python3Packages; [
    importlib-resources
    jinja2
    pydantic
    wstd2daisy
  ];

  pythonImportsCheck = [ "hvcc" ];

  meta = with lib; {
    description = "Python-based dataflow audio programming language compiler";
    longDescription = ''
      HVCC is a Python-based dataflow audio programming language compiler
      that generates C/C++ code and a variety of specific framework wrappers.
      It can be used to compile Pure Data (pd) patches into various formats
      including C, Unity, Wwise, JavaScript, PD externals, Daisy, DPF, and OWL.
    '';
    homepage = "https://github.com/Wasted-Audio/hvcc";
    changelog = "https://github.com/Wasted-Audio/hvcc/blob/${version}/CHANGELOG.md";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ]; # Add yourself if you're submitting to nixpkgs
    platforms = platforms.all;
    mainProgram = "hvcc";
  };
}
