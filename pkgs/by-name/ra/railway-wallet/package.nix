{
  electron,
  fetchFromGitHub,
  fetchYarnDeps,
  lib,
  nodejs,
  stdenv,
  yarnConfigHook,
  yarnBuildHook,
  yarnInstallHook,
}:
let
  pname = "railway-wallet";
  version = "5.17.10";
  repo = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    hash = "sha256-l0zTwi6NuV3bBHcOwEjolhYCSLQnBC6yr7nCP0V5zhg=";
    fetchSubmodules = true;
  };
  src = "${repo}/desktop";
  yarnDeps = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = "sha256-xkYRDlAQElAiJwI1vsGxpvAwzI3l4a9ghZgLd2ify+0=";
  };
in
stdenv.mkDerivation {
  inherit pname src version;

  ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  ELECTRON_OVERRIDE_DIST_PATH = "${electron}";

  yarnOfflineCache = yarnDeps;

  nativeBuildInputs = [
    electron
    yarnConfigHook
    yarnBuildHook
    yarnInstallHook
    nodejs
  ];

  # Post-install steps to build the Electron app
  buildPhase = ''
    export HOME=$(mktemp -d)
    yarn --offline build-prod
    yarn --offline electron:build:linux
  '';

  # Move Electron output to the correct place
  installPhase = ''
    mkdir -p $out/bin
    cp -r ./dist/* $out/bin/
  '';

  meta = {
    description = "Private DeFi wallet for Linux";
    homepage = "https://www.railway.xyz";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ mitchmindtree ];
    platforms = [ "x86_64-linux" ];
  };
}
