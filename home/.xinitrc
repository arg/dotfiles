xrandr &&
xrdb -merge ~/.Xresources &&
xset r rate 300 25 &&
xset s off &&
xset -b &&
feh --bg-center --no-fehbg --randomize ~/wallpapers &&
exec i3
