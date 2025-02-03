args_@{
  lib,
  fetchFromGitLab,
  wlroots,
  libdisplay-info,
  hwdata,
  lcms2,
  ...
}:

let
  metadata = rec {
    domain = "gitlab.freedesktop.org";
    owner = "wlroots";
    repo = "wlroots";
    repo_git = "https://${domain}/${owner}/${repo}";
    branch = "master";
    rev = "d305934ebe6852785a1f425ee96861f0b7280d76";
    sha256 = "sha256-NnPSC5p/phTFe+nWp9vl8LUbmBO/RXSSUuDZ2boucXY=";
  };
  ignore = [
    "wlroots"
    "hwdata"
    "libdisplay-info"
    "lcms2"
  ];
  args = lib.filterAttrs (n: _v: (!builtins.elem n ignore)) args_;
in
(wlroots.override args).overrideAttrs (old: {
  version = "${metadata.rev}";
  buildInputs = old.buildInputs ++ [
    hwdata
    libdisplay-info
    lcms2
  ];
  src = fetchFromGitLab {
    inherit (metadata)
      domain
      owner
      repo
      rev
      sha256
      ;
  };
})
