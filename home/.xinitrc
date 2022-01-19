xrandr &&
xrdb -merge ~/.Xresources &&
xset r rate 300 25 &&
xset s off &&
xset -b &&
feh --bg-center --no-fehbg --randomize ~/wallpapers &&
eval $(/usr/local/bin/gnome-keyring-daemon --start) &&
export SSH_AUTH_SOCK &&
nextcloud --background &&
exec i3
