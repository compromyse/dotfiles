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
    rev = "a8d1e5273abad02e594c4ad2f237a204ca239528";
    sha256 = "sha256-u1YttUkeA/vplXuQs27K38uqDZyBxXZHcbqz7ywRrVY=";
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
