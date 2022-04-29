# Making Ubuntu do what you want

## Ubuntu 22.04

* [install Firefox deb package (no snap)](https://askubuntu.com/a/1404401/220798)
* [Screen-sharing with Wayland](https://askubuntu.com/a/1398720/220798)

## Ubuntu 20.04

* "Upgrade" to [KDE neon](https://neon.kde.org/index)

```
echo "deb http://archive.neon.kde.org/user focal main" | sudo tee /etc/apt/sources.list.d/neon.list
sudo apt update
sudo apt install neon-desktop
```

* Use most recent pipewire to e.g. [use apt-X bluetooth](https://askubuntu.com/a/1364896/220798).

* Useful PPAs ([list packages installed from PPAs](https://askubuntu.com/a/1320843/220798))

  * bleedingedge/focal-bleed/ubuntu : `bash, imagemagick, sqlite3, vim, vlc, zsh, ffmpeg, dav1d` (AV1 video codec), `gdal` (geo), drivers...
  * deadsnakes/ppa/ubuntu : `python3.9, python3.10`
  * libreoffice/ppa/ubuntu : `libreoffice`
  * pipewire-debian/pipewire-upstream/ubuntu : `pipewire`
  * ubuntugis/ubuntugis-unstable/ubuntu : `gdal`
  * savoury1/multimedia/ubuntu: `(lib)gstreamer*`
  * savoury1/backports/ubuntu : `flatpak, git remmina, xdg-desktop-portal`, ...

## Tricks

* [HEIF/AVIF image support](https://askubuntu.com/a/965306/220798)
* [Remove GRUB password](https://askubuntu.com/a/1084922/220798)

