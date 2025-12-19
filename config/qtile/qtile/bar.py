from libqtile.config import Screen
from libqtile import bar, layout, qtile, widget

from const import *

sep = widget.Sep(
    background=bg,
    foreground=fg,
    padding=15,
    linewidth=2,
    size_percent=50
)

screens = [

    Screen(
        wallpaper="/config/dist/everforest.png",
        wallpaper_mode='fill',
        bottom=bar.Bar(
            [
                widget.GroupBox(
                    fontsize=15,
                    highlight_method='block',
                    active=active,
                    block_highlight_text_color=alert,
                    highlight_color=alert,
                    inactive=inactive,
                    foreground=fg,
                    background=bg,
                    this_current_screen_border=bg,
                    this_screen_border=fg,
                    other_current_screen_border=bg,
                    other_screen_border=bg,
                    urgent_border=alert,
                    disable_drag=True,
                ),

                sep,

                widget.WindowName(
                    background=fg,
                    foreground=bg,
                    empty_group_string="Desktop",
                    max_chars=130,
                ),

                widget.Spacer(
                    background=bg,
                    length=8,
                ),

                sep,

                widget.StatusNotifier(
                    background=bg,
                ),

                sep,

                widget.Wlan(
                    background=bg,
                    foreground=fg,
                    format='󰖩  {essid}',
                    interface='wlp3s0'
                ),

                sep,

                widget.Memory(
                    foreground=fg,
                    background=bg,
                    format='󰍛 {MemUsed: .0f}{mm}',
                    update_interval=5,
                ),

                sep,

                widget.Battery(
                    background=bg,
                    foreground=fg,
                    format='  {percent:2.0%}',
                ),

                sep,

                widget.PulseVolume(
                    background=bg,
                    foreground=fg,
                    fmt=" {}",
                ),

                sep,

                widget.Clock(
                    background=bg,
                    foreground=fg,
                    format='  %d %b, %Y',
                ),

                sep,

                widget.Clock(
                    background=bg,
                    foreground=fg,
                    format='  %I:%M %p',
                ),

                widget.Spacer(
                    background=bg,
                    length=5,
                ),
            ],
            28,
        ),
    ),

]

