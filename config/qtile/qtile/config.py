from libqtile import layout
from libqtile.config import Match
from libqtile.lazy import lazy
from libqtile.backend.wayland import InputConfig

from const import *
from bar import *
from keybinds import *

layouts = [
    layout.MonadTall(
        border_focus="#9b9b9b",
        border_normal="#0F1212",
        border_width=2,
        margin=4
        ),
    layout.Max()
]

widget_defaults = dict(
    font="UbuntuMono Nerd Font Mono",
    fontsize=13,
)
extension_defaults = widget_defaults.copy()

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = True
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    border_focus="#0f1212",
    border_normal="#0F1212",
    border_width=4,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="float"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

wl_input_rules = {
    "type:touchpad": InputConfig(tap=True, natural_scroll=True),
    "*": InputConfig(natural_scroll=False),
}

wl_xcursor_theme = None
wl_xcursor_size = 16

wmname = "LG3D"

import os
import subprocess

from libqtile import hook

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('/config/dist/autostart.sh')
    subprocess.Popen([home])

