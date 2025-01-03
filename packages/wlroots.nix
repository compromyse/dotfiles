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
    rev = "38923826c3bd2c8d5752b63570063282e658e2b0";
    sha256 = "sha256-G4P26O08N7zDj3ehhPwqYQm82ij4oI4SI4eehvSagc8=";
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
