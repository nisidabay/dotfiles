--Place this file in your .xmonad/lib directory and import module Colors into .xmonad/xmonad.hs config
--The easy way is to create a soft link from this file to the file in .xmonad/lib using ln -s
--Then recompile and restart xmonad.

module Colors
    ( wallpaper
    , background, foreground, cursor
    , color0, color1, color2, color3, color4, color5, color6, color7
    , color8, color9, color10, color11, color12, color13, color14, color15
    ) where

-- Shell variables
-- Generated by 'wal'
wallpaper="/mnt/sata/Pictures/current_bg_image.png"

-- Special
background="#0c0c0c"
foreground="#c2c2c2"
cursor="#c2c2c2"

-- Colors
color0="#0c0c0c"
color1="#6d685a"
color2="#78705f"
color3="#777464"
color4="#86816c"
color5="#938c75"
color6="#8b907c"
color7="#858585"
color8="#484848"
color9="#928B78"
color10="#A0967F"
color11="#9F9B86"
color12="#B3AC91"
color13="#C4BB9D"
color14="#BAC0A6"
color15="#c2c2c2"