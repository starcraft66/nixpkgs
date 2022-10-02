{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, sphinx
, beautifulsoup4
, docutils
, packaging
}:

buildPythonPackage rec {
  pname = "pydata-sphinx-theme";
  version = "0.10.1";

  format = "wheel";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit version format;
    dist = "py3";
    python = "py3";
    pname = "pydata_sphinx_theme";
    sha256 = "sha256-RzH5N8f0L1Fukn1Svgo1ara5AWmK74MxsJfmxP2BAPQ=";
  };

  propagatedBuildInputs = [
    sphinx
    beautifulsoup4
    docutils
    packaging
  ];

  pythonImportsCheck = [ "pydata_sphinx_theme" ];

  meta = with lib; {
    description = "Bootstrap-based Sphinx theme from the PyData community";
    homepage = "https://github.com/pydata/pydata-sphinx-theme";
    license = licenses.bsd3;
    maintainers = with maintainers; [ marsam ];
  };
}
