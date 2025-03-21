{ lib
, stdenv
, fetchFromGitHub
, installShellFiles
, wayland-scanner
, wayland
, wayland-protocols
, pixman
, fcft
, gtk4
, gtk4-layer-shell
, pkg-config
, writeText
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "dwlb";
  version = "git";

  src = fetchFromGitHub {
    owner = "compromyse";
    repo = "dwlb";
    rev = "compromyse";
    hash = "sha256-te2RB/KB2CtvIo7JOANUkEnn+EQuhvc5+uFSCWPbN7A=";
  };

  nativeBuildInputs = [
    installShellFiles
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    pixman
    wayland
    wayland-protocols
    fcft
    gtk4
    gtk4-layer-shell
  ];

  outputs = [ "out" "man" ];

  makeFlags = [
    "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
    "WAYLAND_SCANNER=wayland-scanner"
    "PREFIX=$(out)"
    "MANDIR=$(man)/share/man"
  ];

  meta = {
    homepage = "https://github.com/compromyse/dwlb/";
    description = "Dynamic window manager for Wayland";
    longDescription = ''
      Feature-Complete Bar for DWL
    '';
    changelog = "https://github.com/compromyse/dwlb/";
    license = lib.licenses.gpl3Only;
    inherit (wayland.meta) platforms;
    mainProgram = "dwlb";
  };
})
