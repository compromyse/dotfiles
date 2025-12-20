{ lib, ... }:

{
  services.fprintd.enable = true;
  security.pam.services.swaylock.text = lib.mkForce ''
    auth sufficient pam_fprintd.so
    auth sufficient pam_unix.so try_first_pass likeauth nullok
    auth include login
  '';
}
