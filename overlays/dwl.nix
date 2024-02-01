final: prev: {
  dwl = prev.dwl.overrideAttrs (oldAttrs: {
    src = super.fetchFromGitHub {
      owner = "compromyse";
      repo = "dwl";
      rev = "v${oldAttrs.version}";
      sha256 = "sha256-U/vqGE1dJKgEGTfPMw02z5KJbZLWY1vwDJWnJxT8urM=";
    };
  });
}
