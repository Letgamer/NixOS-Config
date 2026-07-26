{
  lib,
  fetchFromGitHub,
  python3Packages,
  fetchPypi,
}: let
  pansi = python3Packages.buildPythonPackage rec {
    pname = "pansi";
    version = "2024.11.0"; # Use the appropriate version

    pyproject = true;
    build-system = with python3Packages; [
      setuptools # Required for setup.py
    ];

    src = fetchPypi {
      inherit pname version;
      sha256 = "018186294f012ae48e207d9446b1bd22b0f2ebb2de60a6c4fb079abfacdf4a37";
    };

    propagatedBuildInputs = with python3Packages; [
      pillow
    ];
  };

  interchange = python3Packages.buildPythonPackage rec {
    pname = "interchange";
    version = "2021.0.4"; # Use the appropriate version

    pyproject = true;
    build-system = with python3Packages; [
      setuptools # Required for setup.py
    ];

    src = fetchPypi {
      inherit pname version;
      sha256 = "6791d1b34621e990035fe75d808523172340d80ade1b50412226820184199550";
    };

    propagatedBuildInputs = with python3Packages; [
      pytz
      six
    ];
  };

  py2neo = python3Packages.buildPythonPackage rec {
    pname = "py2neo";
    version = "2021.2.4"; # Correct version

    pyproject = true;
    build-system = with python3Packages; [
      setuptools # Required for setup.py
    ];

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-Syc3/Nn9jYK1foVt5O2gBSgcnPB0HJieUlJnjwUD934=";
    };

    propagatedBuildInputs = with python3Packages; [
      certifi
      chardet
      urllib3
      idna
      monotonic
      interchange
      packaging
      pygments
      pansi
      six
    ];

    meta = {
      description = "Python client library and toolkit for working with Neo4j";
      license = lib.licenses.asl20;
      homepage = "https://github.com/technige/py2neo";
    };
  };
in
  python3Packages.buildPythonApplication {
    pname = "bloodhound-quickwin";
    version = "0-unstable-2025-04-04";
    pyproject = false;

    src = fetchFromGitHub {
      owner = "kaluche";
      repo = "bloodhound-quickwin";
      rev = "b074e80e63acc77fe44095d6d631dd58144e9fce";
      hash = "sha256-PP6+yAGs9w1eNgN8gacb98arfPPLR5HttLlai0RsXkU=";
    };

    dependencies = with python3Packages; [
      py2neo
      pandas
      prettytable
    ];

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      install -Dm755 bhqc.py $out/bin/bhqc.py

      runHook postInstall
    '';

    meta = {
      description = "Simple script to extract useful informations from the combo BloodHound + Neo4j";
      homepage = "https://github.com/kaluche/bloodhound-quickwin";
      maintainers = with lib.maintainers; [letgamer];
      mainProgram = "bhqc.py";
    };
  }
