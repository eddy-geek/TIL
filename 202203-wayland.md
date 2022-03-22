# Is Wayland ready in 2022?

## Web browsers

✅ Yes!

* Firefox, by default
* Chrome, with:
`google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland &`


## Screensharing

✅ Yes!

See my answer for [Screen sharing with Wayland](https://askubuntu.com/a/1398720/220798) on AskUbuntu.

## Custom keyboard layout

While one was able to set a custom keybord layout from command-line in X11 using `xkbcomp` and `setxkbmap`, for Wayland the existing XKB tools were split-forked from X and refactored into libxkbcommon, which mainstream compositors directly embed.

Luckily libxkbcommon 0.10.0 (jan2020) and 1.0.0 (Sep2020) improve things, as explained by Peter Hutterer in a great 4-part blog series [User-specific XKB configuration](https://web.archive.org/web/20210828193033/https://who-t.blogspot.com/2020/09/user-specific-xkb-configuration-putting.html), and  [as well](https://github.com/xkbcommon/libxkbcommon/blob/master/NEWS).

🗲 TODO: try!

## Automation

### Input-centric

* ✅ [Hawck](https://github.com/snyball/Hawck) key-rebinding daemon with lua scripting (root!)

* ✅ KWin Custom shortcuts can input text

* ❌ Tools like xmodmap don't work with Wayland.

* ⏳ Mouse-sharing support between devices or VMs: coming soon? See [barrier#109](https://github.com/debauchee/barrier/issues/109#issuecomment-1049479068)

* ⏳ Global keyboard shortcut portal [xdg-desktop-portal#624](https://github.com/flatpak/xdg-desktop-portal/issues/624)


### Scripting

* ✅ Compositor-specific tools, like KWin scripts and gnome-shell extensions (both in JavaScript).

* ❌ Tools like xdotool, or [autokey](https://github.com/autokey/autokey) don't work with Wayland.

* ❌ GUI-agnostic "screen-scraping" tool [SikuliX](https://sikulix.github.io/), could be adapted to use the screen-sharing portal.


## Other

* Middle-mouse paste - ✅ yes! at least between wayland apps.
