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
    rev = "d835fa813f82501eb668708af33afc42010707cf";
    sha256 = "sha256-YXLa0fjqND7Gys4KK/CZmRqGU70gMVqU3T+j+e6S9qw=";
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
