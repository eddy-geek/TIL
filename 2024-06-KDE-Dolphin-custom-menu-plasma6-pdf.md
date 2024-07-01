# Dolphin custom service menu

The behaviour changed on Fedora 40 / Ubuntu 24.10 with plasma 6

[Dolphin 24.02 - meven's blog](https://www.bivouak.fr/dolphin-24-02/)

> Service menus will need some adaptation unfortunately, you will need to Moving them to a new location.
> Usually mv ~/.local/share/kservices5/ServiceMenus/* ~/.local/share/kio/servicemenus.
> (Ensure to have destination directory created: mkdir -p ~/.local/share/kio/servicemenus)
> 
[Creating Dolphin service menus | Developer](https://develop.kde.org/docs/apps/dolphin/service-menus/)

> In the case of default setups, the path for locating servicemenus has directories the following order:
> ```
> ~/.local/share/kio/servicemenus
> /usr/share/kio/servicemenus
> ```
> When a service menu is installed from Dolphin using Get-Hot-New-Stuff, the local file location is used, because it does not require admin privileges. However, you need to mark the desktop file as executable for it to be considered authorized, because the location is not a standard location that is authorized by default.
> ```
> touch myservicemenu.desktop
> chmod +x myservicemenu.desktop
> ```

Combining both, I had to run the following:

```
mkdir -p ~/.local/share/kio/servicemenus
mv ~/.local/share/kservices5/ServiceMenus/*.desktop ~/.local/share/kio/servicemenus/
chmod +x ~/.local/share/kio/servicemenus/*.desktop
```

For reference here is the desktop file used for the service menu to combine multiple pdf files into a single multi-page pdf, with ghostscript:

```
cat ~/.local/share/kio/servicemenus/combine-pdf.desktop
```

```
[Desktop Entry]
Type=Service
ServiceTypes=KonqPopupMenu/Plugin
MimeType=application/pdf;
Icon=application-pdf
Actions=combine
X-KDE-Priority=TopLevel
X-KDE-RequiredNumberOfUrls=2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32
X-KDE-StartupNotify=false
X-KDE-Submenu=Actions
X-KDE-Submenu[de]=Aktionen

[Desktop Action combine]
Name=Combine *.pdf documents
Name[de]=Kombiniere *.pdf Dokumente
Icon=application-pdf
TryExec=gs
Exec=gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=combined.pdf %U
```

(See also this thread [Service menu plasma 6 - Help - KDE Discuss](https://discuss.kde.org/t/service-menu-plasma-6/11460/7).)
