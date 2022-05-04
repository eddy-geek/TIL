# Switching from KDE/KWin to sway

* features of kde can be replicated at some level with bash scripts
* tools

| What           | KDE                           | Alternatives |
| ---            | ---                           | ---|
| Window Manager | KWin-Wayland                  | Sway
| Panel/Taskbar  | (plasma-workspace)            | [waybar](https://github.com/Alexays/Waybar)
| Start menu     | Kickoff/Kicker/KRunner        | <ul><li>**[rofi (fork)](https://github.com/lbonn/rofi)** or rofi+xwayland - *switcher+launcher+dmenu*<li>[sway-launcher-desktop](https://github.com/Biont/sway-launcher-desktop)<li>[wofi](https://hg.sr.ht/~scoopta/wofi) (unmaintained)<li>dmenu-wl or dmenu+xwayland</ul>
| Settings       | systemsettings5               | [Sway Settings](https://github.com/ErikReider/SwaySettings)
| Notifications  |qml-module-org-kde-notification| <ul><li>[Sway Notification Center](https://github.com/ErikReider/SwayNotificationCenter)<li>[mako](https://github.com/emersion/mako)</ul>
| Screen locker  | libkscreenlocker5             | [swaylock](https://github.com/swaywm/swaylock) screen locker
| Clipboard      | Klipper                       | wl-clipboard
| Screen capture | Spectacle                     | <ul><li>[slurp](https://github.com/emersion/slurp) + [grim](https://sr.ht/~emersion/grim/)<li>flameshot</ul>
| Sound          | plasma-pa                     | pavucontrol
| Network        | plasma-nm                     | nm-applet/nmtui
| Bluetooth      | qml-module-org-kde-bluezqt    | blueman/bluethoothctl
| Idle manager   |                               | swayidle  


In ubuntu jammy repo: `flameshot grimshot slurp sway swaybg swayidle swaylock waybar wl-clipboard wofu`. Missing: Sway Settings, SwayNC, rofi-fork.
