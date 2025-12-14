from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.backend.wayland import InputConfig

mod = "mod4"
terminal = "alacritty"
launcher = "/config/dist/run.sh"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    # Move windows between left/right columns or move up/down in current stack.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),

    Key([mod, "shift"], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "space", lazy.spawn(launcher), desc="Launcher"),

    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5"), desc='Volume up'),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5"), desc='Volume down'),
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t"), desc='Volume Mute'),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s 5%+"), desc='brightness UP'),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%-"), desc='brightness Down'),
    Key([mod], "e", lazy.spawn("pcmanfm"), desc='File manager'),
    Key([mod], "x", lazy.spawn("swaylock"), desc='Lock'),
    # Key([mod], "s", lazy.spawn("flameshot gui"), desc='Screenshot'),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "b", lazy.shutdown(), desc="Shutdown Qtile"),

    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

# Add key bindings to switch VTs in Wayland.
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt),
            desc=f"Switch to VT{vt}"
        )
    )


groups = [Group(f"{i+1}", label="") for i in range(9)]

for i in groups:
    keys.extend(
            [
                Key(
                    [mod],
                    i.name,
                    lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name),
                    ),
                Key(
                    [mod, "shift"],
                    i.name,
                    lazy.window.togroup(i.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(i.name),
                    ),
                ]
            )

layouts = [
    layout.MonadTall(
        border_focus="#202222",
        border_normal="#0F1212",
        border_width=4,
        margin=8
        ),
    layout.Max()
]

widget_defaults = dict(
    font="UbuntuMono Nerd Font",
    fontsize=14,
    padding=4
)
extension_defaults = widget_defaults.copy()

screens = [

    Screen(
        wallpaper="/config/dist/wallpaper.png",
        wallpaper_mode='fill',
        top=bar.Bar(
            [
                widget.GroupBox(
                    fontsize=24,
                    borderwidth=3,
                    highlight_method='block',
                    active='#607767',
                    block_highlight_text_color="#B2BEBC",
                    highlight_color='#202222',
                    inactive='#0F1212',
                    foreground='#4B427E',
                    background='#202222',
                    this_current_screen_border='#202222',
                    this_screen_border='#202222',
                    other_current_screen_border='#202222',
                    other_screen_border='#202222',
                    urgent_border='#202222',
                    rounded=True,
                    disable_drag=True,
                ),

                widget.Sep(
                    background='#202222',
                    padding=14,
                    linewidth=2,
                    size_percent=50
                ),

                widget.WindowName(
                    background='#202222',
                    empty_group_string="Desktop",
                    max_chars=130,
                    foreground='#607767',
                ),

                widget.Spacer(
                    length=8,
                    background='#0F1212',
                ),

                widget.Sep(
                    background='#0F1212',
                    foreground='#607767',
                    padding=10,
                    linewidth=2,
                    size_percent=50
                ),

                widget.StatusNotifier(
                    background='#0F1212',
                    fontsize=2,
                ),

                widget.Sep(
                    background='#0F1212',
                    foreground='#607767',
                    padding=10,
                    linewidth=2,
                    size_percent=50
                ),

                widget.Wlan(
                    fontsize=13,
                    background='#0F1212',
                    foreground='#607767',
                    format='󰖩  {essid}',
                    interface='wlp3s0'
                ),

                widget.Sep(
                    background='#0F1212',
                    foreground='#607767',
                    padding=10,
                    linewidth=2,
                    size_percent=50
                ),

                widget.Memory(
                    format='󰍛 {MemUsed: .0f}{mm}',
                    foreground='#607767',
                    background='#0F1212',
                    update_interval=5,
                ),

                widget.Sep(
                    background='#0F1212',
                    foreground='#607767',
                    padding=10,
                    linewidth=2,
                    size_percent=50
                ),

                widget.Battery(
                    background='#0F1212',
                    foreground='#607767',
                    format='  {percent:2.0%}',
                ),

                widget.Sep(
                    background='#0F1212',
                    foreground='#607767',
                    padding=10,
                    linewidth=2,
                    size_percent=50
                ),

                widget.PulseVolume(
                    fontsize=13,
                    background='#0F1212',
                    foreground='#607767',
                    fmt=" {}"
                ),

                widget.Sep(
                    background='#0F1212',
                    foreground='#607767',
                    padding=10,
                    linewidth=2,
                    size_percent=50
                ),

                widget.Clock(
                    format='  %d %b, %Y',
                    background='#0F1212',
                    foreground='#607767',
                ),

                widget.Sep(
                    background='#0F1212',
                    foreground='#607767',
                    padding=10,
                    linewidth=2,
                    size_percent=50
                ),

                widget.Clock(
                    format='  %I:%M %p',
                    background='#0F1212',
                    foreground='#607767',
                ),
            ],
            28,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = True
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    border_focus="#202222",
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
    "*": InputConfig(tap=True, natural_scroll=True)
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
