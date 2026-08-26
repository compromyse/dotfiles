{ config, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/x-virt-viewer" = "remote-viewer.desktop";
    };
  };
}
