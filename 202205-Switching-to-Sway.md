# Switching from KDE/KWin to sway

All-in-one aproach: [nwg-shell](https://github.com/nwg-piotr/nwg-shell) & [archlabslinux](https://archlabslinux.com/)

Wayland ecosystem:
* **[Useful add ons for sway](https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway)** and [Common X11 apps used on i3 with Wayland alternatives](https://github.com/swaywm/sway/wiki/i3-Migration-Guide#common-x11-apps-used-on-i3-with-wayland-alternatives)
* [Wayland_Desktop_Landscape](https://wiki.gentoo.org/wiki/Wayland_Desktop_Landscape)
* https://arewewaylandyet.com

*Below I list some comnmon choices, full list above.*

| What           | KDE                           | Alternatives |
| ---            | ---                           | ---|
| Window Manager | KWin-Wayland                  | Sway
| Panel/Taskbar  | (plasma-workspace)            | [waybar](https://github.com/Alexays/Waybar) (better than stock `swaybar`)
| App launchers  | Kickoff/Kicker/KRunner        | <ul><li>**[rofi (fork)](https://github.com/lbonn/rofi)** or rofi+xwayland - *switcher+launcher+dmenu*<li>[sway-launcher-desktop](https://github.com/Biont/sway-launcher-desktop)<li>[wofi](https://hg.sr.ht/~scoopta/wofi) (unmaintained)<li>[dmenu-wl](https://github.com/nyyManni/dmenu-wayland) or dmenu+xwayland</ul>
| App switcher   |                               | Rofi or [Swayr](https://sr.ht/~tsdh/swayr/)
| Notifications  |qml-module-org-kde-notification| <ul><li>[Sway Notification Center](https://github.com/ErikReider/SwayNotificationCenter)<li>[mako](https://github.com/emersion/mako)</ul>
| Screen locker  | libkscreenlocker5             | [swaylock](https://github.com/swaywm/swaylock) screen locker
| Clipboard      | Klipper                       | wl-clipboard
| Screen capture | Spectacle                     | <ul><li>[slurp](https://github.com/emersion/slurp) + [grim](https://sr.ht/~emersion/grim/)<li>flameshot</ul>
| Screen sharing | xdg-desktop-portal-kde        | [xdg-desktop-portal-wlr](https://github.com/emersion/xdg-desktop-portal-wlr)
| Settings       | systemsettings5               | [Sway Settings](https://github.com/ErikReider/SwaySettings), nwg-shell-config, kanshi, wdisplays
| Sound          | plasma-pa                     | pavucontrol
| Network        | plasma-nm                     | nm-applet/nmtui
| Bluetooth      | qml-module-org-kde-bluezqt    | blueman/bluethoothctl
| Idle manager   |                               | swayidle  

For quick application focus-or-run:
* on KDE I used KWin scripts
* on Sway, see [Window switching in Sway](https://curiouscoding.nl/2021/07/01/sway-window-switching/)

Distro support
* Arch has the best support
* In ubuntu jammy repo: `flameshot gammastep grimshot kanshi mako-notifier slurp sway swaybg swayidle swaylock waybar wdisplay wl-clipboard wlroots wofu xdg-desktop-portal-wlr`. Missing: Sway Settings, SwayNC, rofi-fork, alacritty.
* [fedora packages](https://fedoraproject.org/wiki/SIGs/Sway)
