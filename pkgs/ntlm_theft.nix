{
  lib,
  fetchFromGitHub,
  python3Packages,
  versionCheckHook,
}:
python3Packages.buildPythonApplication {
  pname = "ntlm_theft";
  version = "0.1.0-unstable-2025-09-22";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "Greenwolf";
    repo = "ntlm_theft";
    rev = "9750e537444a411e99555155b3a32fad745ae3d4";
    hash = "sha256-wahjAokAbOa9gpiLO77ZgMaqWCOH34oJBrbEqgoxz8E=";
  };

  dependencies = with python3Packages; [
    xlsxwriter
  ];

  postPatch = ''
    # Fix broken shebang
    substituteInPlace ntlm_theft.py \
      --replace-fail "#!/usr/bin/env" "#!/usr/bin/env python3"

    # Fix file permissions and timestamps as copytree normally inherits the metadata from the nix store which leads to unwriteable files
    substituteInPlace ntlm_theft.py \
      --replace-fail \
      'import shutil' \
      'import shutil; shutil.copystat = lambda *args, **kwargs: None'
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 ntlm_theft.py $out/share/ntlm_theft/ntlm_theft

    cp -r templates $out/share/ntlm_theft/

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper "$out/share/ntlm_theft/ntlm_theft" "$out/bin/ntlm_theft" \
      --prefix PATH : "$program_PATH" \
      --prefix PYTHONPATH : "$program_PYTHONPATH"
  '';

  nativeInstallCheckInputs = [versionCheckHook];
  preVersionCheck = "export version=0.1.0";
  doInstallCheck = true;

  meta = {
    description = "Tool for generating multiple types of NTLMv2 hash theft files";
    homepage = "https://github.com/Greenwolf/ntlm_theft";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [letgamer];
    mainProgram = "ntlm_theft";
  };
}
