{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  pythonRelaxDepsHook,
  sphinxHook,
  # Dependencies
  poetry-core,
  pydantic,
  httpx,
  # Documentation
  sphinx-rtd-theme,
  myst-parser,
  # Testing
  pytestCheckHook,
  respx,
}:
buildPythonPackage rec {
  pname = "libsimba";
  version = "0.1.14";
  format = "pyproject";
  disabled = pythonOlder "3.9";

  outputs = ["out" "doc" "man"];

  src = fetchFromGitHub {
    owner = "SIMBAChain";
    repo = pname;
    rev = "d293ab1abf44fd24fba96eaaeea509b0b4b6508c";
    hash = "sha256-Awp49lBr83InlQf7G4rOEsVwnwsIyhrpbwyz9e0Y0KQ=";
  };

  nativeBuildInputs = [
    poetry-core
    pythonRelaxDepsHook
    sphinxHook
    sphinx-rtd-theme
    myst-parser
  ];

  pythonRelaxDeps = ["pydantic" "httpx"];
  sphinxBuilders = ["singlehtml" "man"];
  sphinxRoot = "sphinx/source";

  propagatedBuildInputs = [
    pydantic
    httpx
  ];

  nativeCheckInputs = [pytestCheckHook];

  checkInputs = [
    respx
  ];

  SIMBA_AUTH_CLIENT_SECRET = "dummy";
  SIMBA_AUTH_CLIENT_ID = "dummy";
  SIMBA_AUTH_BASE_URL = "https://my.blocks.server";
  SIMBA_API_BASE_URL = "https://my.blocks.server";
  pythonImportsCheck = ["libsimba"];

  passthru = {
    optional-dependencies = {};
  };

  meta = with lib; {
    description = "libsimba is a library simplifying the use of SIMBAChain Blocks APIs.";
    homepage = "https://github.com/SIMBAChain/libsimba";
    # changelog = "https://github.com/iterative/PyDrive2/releases/tag/${version}";
    license = licenses.mit;
  };
}
