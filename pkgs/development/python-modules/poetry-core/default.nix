{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, build
, git
, importlib-metadata
, pep517
, pytest-mock
, pytestCheckHook
, setuptools
, tomlkit
, virtualenv
}:

buildPythonPackage rec {
  pname = "poetry-core";
  version = "1.2.0";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "python-poetry";
    repo = pname;
    rev = version;
    hash = "sha256-d/VhnG+6qabgLMb8ki46R9+lpCwZNlS8QpM8u3VYmWs=";
  };

  propagatedBuildInputs = lib.optionals (pythonOlder "3.8") [
    importlib-metadata
  ];

  checkInputs = [
    build
    git
    pep517
    pytest-mock
    pytestCheckHook
    setuptools
    tomlkit
    virtualenv
  ];

  # Requires git history to work correctly
  disabledTests = [
    "default_with_excluded_data"
    "default_src_with_excluded_data"
  ];

  pythonImportsCheck = [
    "poetry.core"
  ];

  # Allow for package to use pep420's native namespaces
  pythonNamespaces = [
    "poetry"
  ];

  meta = with lib; {
    description = "Core utilities for Poetry";
    homepage = "https://github.com/python-poetry/poetry-core/";
    license = licenses.mit;
    maintainers = with maintainers; [ jonringer ];
  };
}
