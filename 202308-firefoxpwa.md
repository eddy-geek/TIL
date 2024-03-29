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
* *firefoxpwa.allowedDomains* =	*login.live.com,login.microsoftonline.com,adfs.a.com*
* *firefoxpwa.launchType* -- *2 - Replace the existing tab*
* *firefoxpwa.shortcuts.closeTab = false*

# Other firefox customizations of interest

(mostly in about:config)

* _widget.use-xdg-desktop-portal.mime-handler	= 1_
* _widget.use-xdg-desktop-portal.file-picker = 1_
  <br>→ use KDE file dialog (source [Firefox - ArchWiki](https://wiki.archlinux.org/title/Firefox))

* [Tab Stash](https://addons.mozilla.org/en-US/firefox/addon/tab-stash/)
  * default hotkey Ctrl+Alt+S
  * css change <a href="https://gist.github.com/BrianGilbert/1ad7e3931406f485a86a35aefb0aa1b1">Firefox userChrome to autohide Sideberry panel and hide titlebar tabs, and autohide Page Actions.</a>
  <br>*(in the end I heavily modified this and should put my own gist somewhere)*

* [CopyTabTitleUrl](https://addons.mozilla.org/en-GB/firefox/addon/copytabtitleurl/), with following settings:
  * Extended mode
  * Enable format2
  * shortcuts:
    * format1 = Ctrl+Shift+C = markdown (default) = `[${title}](${url})`
    * format2 = Alt-C = `<a href="${url}">${title}</a>`
  * Copy in text/html format

* _toolkit.legacyUserProfileCustomizations.stylesheets = true_
<br> allow userChrome.css to remove tabs

* Permanently hide tab bar in full-screen: [SO](https://superuser.com/a/1750613)
* <a href="https://gist.github.com/zzag/e2f0a5e022b726466c29afa3d497a3fc">Firefox Nightly desktop file</a>

## Annex

for sidebar font size

The default sidebar text size seems not to be customized, somehow 13.333 px (while the firefox settings say 16 for default font size...).
![image](https://github.com/eddy-geek/TIL/assets/2772505/1b452c92-39a4-4009-9b51-97c0f1bcd282)
try 1.5em ?
For the CSS of the sidebar, it can be set globally for #sidebar or depending on what kind of content is displayed, eg *Bookmarks* are in `#bookmarksPanel > tree #bookmarks-view` while *Synced Tabs* are in `.tabs-container > .item .tab`, precisely:

```
html body div.content-container div#template-container.content-scrollable div div.deck div.tabs-container.sync-state.selected div div.tabs-container div.list div#item-foobar.item.client div.item-tabs-list div#tab-foobaz-0.item.tab div.item-title-container p.item-title
```

while in sidebar.css we have eg.:

```
#sidebar-header {
  font-size: 1.333em;
```

other useful Vertical tabs extensions mentioned on HN:
* [All Tabs Helper](https://addons.mozilla.org/en-US/firefox/addon/all-tabs-helper/)
* [Tab Session Manager](https://addons.mozilla.org/en-US/firefox/addon/tab-session-manager/)
