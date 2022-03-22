# Is Wayland ready in 2022?

## Chrome

Yes!

`google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland &`

## Screensharing


```
sudo apt install xdg-desktop-portal-gnome gnome-remote-desktop

systemctl --user start pipewire-media-session
```

*(`gnome-remote-desktop` depends on `pipewire-media-session`)*
