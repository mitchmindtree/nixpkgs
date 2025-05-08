{
  lib,
  python3,
  fetchPypi,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "wstd2daisy";
  version = "0.5.3";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-HPa7xtCM8fTTbBqsLxygx6ezk8STCHV7s/kbBfjPOXo=";
  };

  nativeBuildInputs = with python3.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python3.pkgs; [
    jinja2
  ];

  pythonImportsCheck = [ "json2daisy" ];

  meta = {
    description = "Utility for converting JSON board definitions into Daisy board support files";
    homepage = "https://github.com/Wasted-Audio/json2daisy";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ mitchmindtree ];
  };
}
