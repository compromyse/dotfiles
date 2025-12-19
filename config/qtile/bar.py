screens = [

    Screen(
        wallpaper="/config/dist/everforest.png",
        wallpaper_mode='fill',
        bottom=bar.Bar(
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

