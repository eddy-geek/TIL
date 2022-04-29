# Making Ubuntu do what you want

## Tricks

* [HEIF/AVIF image support](https://askubuntu.com/a/965306/220798)
* [list packages installed from PPAs](https://askubuntu.com/a/1320843/220798)
* [Remove GRUB password](https://askubuntu.com/a/1084922/220798)


## Ubuntu 22.04

* [install Firefox deb package (no snap)](https://askubuntu.com/a/1404401/220798)
* [Screen-sharing with Wayland](https://askubuntu.com/a/1398720/220798) [with wireplumber](https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1966436)

* Useful PPAs
  * [deadsnakes/ppa](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa?field.series_filter=jammy) : `python3.11`
  * [savoury1/backports](https://launchpad.net/~savoury1/+archive/ubuntu/backports?field.series_filter=jammy)
  * [savoury1/fonts](https://launchpad.net/~savoury1/+archive/ubuntu/fonts?field.series_filter=jammy)
  * [savoury1/graphics](https://launchpad.net/~savoury1/+archive/ubuntu/graphics?field.series_filter=jammy)
  * [savoury1/multimedia](https://launchpad.net/~savoury1/+archive/ubuntu/multimedia?field.series_filter=jammy)


## Ubuntu 20.04

* "Upgrade" to [KDE neon](https://neon.kde.org/index)

```
echo "deb http://archive.neon.kde.org/user focal main" | sudo tee /etc/apt/sources.list.d/neon.list
sudo apt update
sudo apt install neon-desktop
```

* [Replace PulseAudio with Pipewire](https://askubuntu.com/a/1339897/220798) to e.g. [use apt-X bluetooth](https://askubuntu.com/a/1364896/220798). See also 

* Useful PPAs

  * [bleedingedge/focal-bleed](https://launchpad.net/~bleedingedge/+archive/ubuntu/focal-bleed) : `bash, imagemagick, sqlite3, vim, vlc, zsh, ffmpeg, dav1d` (AV1 video codec), `gdal` (geo), drivers...
  * [deadsnakes/ppa](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa?field.series_filter=focal) : `python3.9, python3.10`
  * libreoffice/ppa : `libreoffice`
  * pipewire-debian/pipewire-upstream : `pipewire`
  * [ubuntugis/ubuntugis-unstable](https://launchpad.net/~ubuntugis/+archive/ubuntu/ubuntugis-unstable) : `gdal`
  * [savoury1](https://launchpad.net/~savoury1)/backports : `flatpak, git remmina, xdg-desktop-portal`, ...
  * savoury1/multimedia: `(lib)gstreamer*`

