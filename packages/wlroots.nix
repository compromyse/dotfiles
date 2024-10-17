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
    rev = "47fb00f66d5a8367d0108bd960f99e51ab1a1318";
    sha256 = "sha256-HkpTML14tbYBLiHkqoFRSn/qKsVny/oso2TuG6LY/fk=";
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
