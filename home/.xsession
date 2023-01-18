xrandr &&
xrdb -merge ~/.Xresources &&
xset r rate 300 25 &&
xset s off &&
xset -b &&
xmodmap ~/.Xmodmap &&
feh --bg-center --no-fehbg --randomize ~/wallpapers &&
eval $(/usr/bin/gnome-keyring-daemon --start) &&
export SSH_AUTH_SOCK &&
exec i3
