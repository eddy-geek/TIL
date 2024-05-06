# Is Wayland ready in 2022?

TL;DR: **"Yes but"**:
* lack of focus stealing (WIP) is really annoying.
* Command-line setup is needed as many apps will run on XWayland *by default* -- which is "transparent" until it isn't (eg fractional scaling on HiDPI displays)
* Stability is worse compared to X11 session due to intolerance to crashes [RH#1367666](https://bugzilla.redhat.com/show_bug.cgi?id=1367666)

## Compositors

✅ Mature compositors include Gnome-Shell (Mutter), KWin/KWinFT, SwayWM, Hikari

## Web browsers

✅ Yes!

* Firefox, by default
* With Chrome > 97: `google-chrome-stable --ozone-platform-hint=auto`. I still experience random crashes though (as of March '22).
  * Previously, since around Chrome 91 / May 2021, with a [flag](https://bugs.chromium.org/p/chromium/issues/detail?id=1085700):
`google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland &`


## Screensharing

✅ Yes!

See my answer for [Screen sharing with Wayland](https://askubuntu.com/a/1398720/220798) on AskUbuntu.

## Custom keyboard layout

While one was able to set a custom keybord layout from command-line in X11 using `xkbcomp` and `setxkbmap`, for Wayland the existing XKB tools were split-forked from X and refactored into libxkbcommon, which mainstream compositors directly embed.

Luckily libxkbcommon 0.10.0 (Jan2020) and 1.0.0 (Sep2020) improve things, as explained by Peter Hutterer in a great 4-part blog series [User-specific XKB configuration](https://web.archive.org/web/20210828193033/https://who-t.blogspot.com/2020/09/user-specific-xkb-configuration-putting.html).

See the libxkbcommon [User-configuration](https://xkbcommon.org/doc/current/md_doc_user_configuration.html) doc.

🗲 TODO: try! 

Also, the [pre-supplied <i>custom</i> keyboard layout](https://web.archive.org/web/20210303023436/https://who-t.blogspot.com/2021/02/a-pre-supplied-custom-keyboard-layout.html) in xkeyboard-config 2.33 works in both Wayland and X11. In Ubuntu 22.04:

<img src="https://user-images.githubusercontent.com/2772505/159658641-cc084ad7-f7f8-4629-a40e-7d75bfdc0fd6.png" width="262">


## Automation

### Input-centric

* ✅ [Hawck](https://github.com/snyball/Hawck) key-rebinding daemon with lua scripting (root!)

* ✅ [phil294/AHK_X11: AutoHotkey for Linux (X11-based systems)](https://github.com/phil294/AHK_X11)

* ✅ KDE - ~Plasma Custom shortcuts can input text~<br>
  ❌ Custom Shortcuts removed in 5.25 [Plasma bug](https://bugs.kde.org/show_bug.cgi?id=455444)

* 🕱 Tools like xmodmap, xbindkeys don't work with Wayland, but feature-set is arguably covered by the above.

* ⏳ Mouse-sharing support between devices or VMs: coming soon? See [barrier#109](https://github.com/debauchee/barrier/issues/109#issuecomment-1049479068)

* ✅ Global keyboard shortcut portal [xdg-desktop-portal#624](https://github.com/flatpak/xdg-desktop-portal/issues/624) (Sep'22, KDE support Feb'23/5.27)


### Scripting

* ✅ Compositor-specific tools, like KWin scripts and gnome-shell extensions (both in JavaScript).

* ❌⏳ Tools like xdotool, or [autokey](https://github.com/autokey/autokey) don't work with Wayland. Partial support in [ydotool](https://github.com/ReimuNotMoe/ydotool)

* ❌ GUI-agnostic "screen-scraping" tool [SikuliX](https://sikulix.github.io/), could be adapted to use the screen-sharing portal. See ([JDK-8269245](https://bugs.openjdk.org/browse/JDK-8269245)).

## Toolkits

### Qt in Gnome

✅ Yes with setup. By default 
* Qt apps start with X and *`Warning: Ignoring XDG_SESSION_TYPE=wayland on Gnome. Use QT_QPA_PLATFORM=wayland to run on Wayland anyway.`*
Workaround with `` in `~/.profile`
* They look bad, especially when using GTK4 Adwaita-dark, and the default `qt5-gtk-platformtheme` makes it worse. I went with the default KDE look doing the following:
```bash
sudo apt remove qt5-gtk-platformtheme
sudo apt install breeze plasma-integration
# in ~/.profile:
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=kde
```

![Screenshot from 2022-03-23 16-45-23](https://user-images.githubusercontent.com/2772505/159740347-ec622567-6ffd-460d-a9ea-207ecc30d7ca.png)

## Dev tools

* ✅ VSCode ([issue](https://github.com/microsoft/vscode/issues/109176)) (easier config issue [electron#30897](https://github.com/electron/electron/issues/30897)

```sh
echo "--enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer
--ozone-platform=wayland
--ozone-platform-hint=auto" >! ~/.config/electron17-flags.conf
```

## Fractional scaling

Overall better (at least in KDE). One nitpick is apps which need to display in native resolution to avoid blurry images:
* Gwenview - [465688 – &quot;Fit&quot; on fractionally scaled wayland display doesn't actually fit](https://bugs.kde.org/show_bug.cgi?id=465688)
* [GPXSee#478 Fractional scaling support on wayland](https://github.com/tumic0/GPXSee/issues/478) & upstream qt bug.

Historical references:
* Qt `devicePixelRatio` was introduced with [High-DPI Support in Qt 5.6](https://www.qt.io/blog/2016/01/26/high-dpi-support-in-qt-5-6)
* Implementation was done in Qt 6 used in Plasma 6.0 but never backported - [466373 – Qt apps don't use wp-fractional-scale-v1 for hidpi fractional scaling on Wayland](https://bugs.kde.org/show_bug.cgi?id=466373) -*includes [gist](https://gist.github.com/eddy-geek/2a682a415abb5d351537ae3fc865dffd) and image to debug issues*

## Other

* Middle-mouse paste - ✅ yes! at least between wayland apps.

* Focus stealing - ❌ - *mentioned in KDE's [Plasma/Wayland Showstoppers](https://community.kde.org/Plasma/Wayland_Showstoppers)
  * KDE should have [Full xdg_activation_v1 support](https://invent.kde.org/plasma/kwin/-/issues/39)
  * Sway has support as well since March '21, [sway#6132](https://github.com/swaywm/sway/pull/6132)
  * Gnome was the first to have a custom extension
  * ... but **apps do not support it**:
    * [Previously opened Firefox window is not focused when opening a link from other applications](https://bugzilla.mozilla.org/show_bug.cgi?id=1766269) / [Support XDG_ACTIVATION_TOKEN env var](https://bugzilla.mozilla.org/show_bug.cgi?id=1767546) -> Fixed in FF-108, merged 2022/11/08.
    * Chromium [wayland: Support window activation via standard extensions](https://bugs.chromium.org/p/chromium/issues/detail?id=1175327) - merged 2022/08/16
    * Electron [Implement support for xdg_activation_v1 Wayland protocol](https://github.com/electron/electron/issues/30912)
