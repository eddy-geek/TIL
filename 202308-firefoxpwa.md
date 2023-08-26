# Firefox PWA

Firefox only supports PWA with an extension.

Latest deb can be downloaded from [github/filips123/PWAsForFirefox/releases](https://github.com/filips123/PWAsForFirefox/releases)

Commands to setup what I need:

```bash
firefoxpwa runtime install
firefoxpwa site install https://teams.microsoft.com/manifest.json --name "MS Teams FF"
firefoxpwa site install "https://outlook.office.com/mail/manifests/pwa.json?culture=en" --name "Outlook FF"
```

Settings to enable in the main FF [extension](https://addons.mozilla.org/firefox/addon/pwas-for-firefox/):

* Launch Web apps
* Use Wayland
* Use XDG portals

Settings to enable in each webapp's `about:config`:

* *firefoxpwa.openOutOfScopeInDefaultBrowser* = *true*
* *firefoxpwa.allowedDomains* =	*login.live.com,login.microsoftonline.com*
* *firefoxpwa.launchType* -- maybe *2 - Replace the existing tab*
