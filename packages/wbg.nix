{
  stdenv,
  lib,
  fetchFromGitea,
  pkg-config,
  meson,
  ninja,
  pixman,
  tllist,
  wayland,
  wayland-scanner,
  wayland-protocols,
  nanosvg,
  libjxl,
  enablePNG ? true,
  enableJPEG ? true,
  enableWebp ? true,
  # Optional dependencies
  libpng,
  libjpeg,
  libwebp,
}:

stdenv.mkDerivation rec {
  pname = "wbg";
  version = "1.2.0";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "dnkl";
    repo = "wbg";
    rev = "master";
    hash = "sha256-ikwOVtR5cXZGd2GE/O4ej6cOQZomyEKkPcKe08EtPw0=";
  };

  nativeBuildInputs = [
    pkg-config
    meson
    ninja
    wayland-scanner
  ];

  buildInputs =
    [
      pixman
      tllist
      wayland
      wayland-protocols
      nanosvg
      libjxl
    ]
    ++ lib.optional enablePNG libpng
    ++ lib.optional enableJPEG libjpeg
    ++ lib.optional enableWebp libwebp;

  mesonBuildType = "release";

  mesonFlags = [
    (lib.mesonEnable "system-nanosvg" true)
    (lib.mesonEnable "png" enablePNG)
    (lib.mesonEnable "jpeg" enableJPEG)
    (lib.mesonEnable "webp" enableWebp)
  ];

  meta = with lib; {
    description = "Wallpaper application for Wayland compositors";
    homepage = "https://codeberg.org/dnkl/wbg";
    changelog = "https://codeberg.org/dnkl/wbg/releases/tag/${version}";
    license = licenses.isc;
    maintainers = with maintainers; [ ];
    platforms = with platforms; linux;
    mainProgram = "wbg";
  };
}
