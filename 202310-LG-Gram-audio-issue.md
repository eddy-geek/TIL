## Issue

No speaker sound on my LG Gram 2-in-1, but jack and bluetooth work (configuration details in the annex)

## Investigation

All of these point to a set of hda-driver commands that did not work for me
  * thesofproject/linux#4055 *Samsung Galaxy Book2 Pro 360 no sound through speaker* ⭐
  * thesofproject/linux#4363 *No sound on LG Gram 17 inch from 2023 (model: 17Z90R)* ⭐

This is for tracing windows driver calls:

* (2021) [How to sniff verbs from a Windows sound driver · ryanprescott/realtek-verb-tools Wiki · GitHub](https://github.com/ryanprescott/realtek-verb-tools/wiki/How-to-sniff-verbs-from-a-Windows-sound-driver)
* (2018) [Setup and usage of the program · Conmanx360/QemuHDADump Wiki · GitHub](https://github.com/Conmanx360/QemuHDADump/wiki/Setup-and-usage-of-the-program)
* (2018 fork) [GitHub - abridgewater/QemuHDADump: Dumps HDA verbs from the CORB buffer of a virtual machine. Useful for reverse engineering drivers on different operating systems.](https://github.com/abridgewater/QemuHDADump)
* [kernel bug 207423 c#24](https://bugzilla.kernel.org/show_bug.cgi?id=207423#c24) *930MBE, Realtek ALC298, Speaker, Internal, No sound on internal speakers* has additional explanations on the fork

Bug 207423 led to patches in Sep22 like [LKML: Greg Kroah-Hartman: PATCH 5.19 145/155 ALSA: hda/realtek: Add speaker AMP init for Samsung laptops with ALC298](https://lkml.org/lkml/2022/9/6/964)
which should have ended on/around linux 5.10.

For ref the current (Sep23) version of the patched file is [patch_realtek.c - Linux source code (v6.6-rc2) - Bootlin](https://elixir.bootlin.com/linux/v6.6-rc2/source/sound/pci/hda/patch_realtek.c)

Success was reported in running the samsung stuff on LG Gram 16Z90R-A and 17Z90R-K.ADS9U1 in [[SOLVED] Fixing ALC298 audio (no sound from speakers - Fedora)](https://forums.fedoraforum.org/showthread.php?331130-Fixing-ALC298-audio-(no-sound-from-speakers)) and then [alsa - No sound from speaker on LG gram 2023 (i7-1360P) - Ask Ubuntu](https://askubuntu.com/questions/1467911/no-sound-from-speaker-on-lg-gram-2023-i7-1360p/1486091).

---

So, I tried the following commands were used to try the samsung [hda-verb](https://www.kernel.org/doc/html/latest/sound/hd-audio/notes.html#hda-verb) workaround from joshuagrisham posted on #4055 (Sep22):

```sh
sudo apt install -y alsa-tools
wget https://github.com/joshuagrisham/galaxy-book2-pro-linux/raw/main/sound/necessary-verbs.sh

chmod +x necessary-verbs.sh
sudo ./necessary-verbs.sh

sudo mv necessary-verbs.sh /usr/local/sbin/necessary-verbs.sh

cat <<EOF | sudo tee /etc/systemd/system/audio-fix-alc298.service
[Unit]
Description=Run internal speaker fix script at startup
After=getty.target

[Service]
Type=simple
ExecStart=/usr/local/sbin/necessary-verbs.sh
TimeoutStartSec=0

[Install]
WantedBy=default.target
EOF

sudo systemctl enable audio-fix-alc298.service
```

and the following to activate the kernel patch as per [set up the audio card in Samsung Galaxy Book - Manjaro Linux](https://forum.manjaro.org/t/howto-set-up-the-audio-card-in-samsung-galaxy-book/37090/36) ⭐ (more doc: [Early patching - More Notes on HD-Audio Driver — The Linux Kernel documentation](https://www.kernel.org/doc/html/latest/sound/hd-audio/notes.html#early-patching):

```sh
sudo tee /etc/modprobe.d/audio-fix-alc298--samsung-headphone.conf <<< 'options snd-hda-intel model=alc298-samsung-amp'
```

and also the longer verb list from [216023 – Speakers not working in Samsung Book2 NP950QED](https://bugzilla.kernel.org/show_bug.cgi?id=216023#c14)

...without success after reboots.

Also no improvement after upgrading to kernel 6.5.0-060500rc7-generic using `mainline` tool installed from cappelikan ppa.

[linux - Ubuntu 20.04 LTS no sound on LG Gram 2021 (a lot of troubleshooting attempted) - Super User](https://superuser.com/questions/1627065/ubuntu-20-04-lts-no-sound-on-lg-gram-2021-a-lot-of-troubleshooting-attempted) was also not helpful, but it pointed to this:

**Comment#13 for the exact same model worked!** in [kernel bug 212041 #13](https://bugzilla.kernel.org/show_bug.cgi?id=212041#c13) *LG Gram (2021 Tiger Lake) No sound internel speaker* 🥳


## Annex - config

* 16T90R-K.ADB9U1, 1360P, Ubuntu 22.04, ALSA v: k5.19.0-46-generic, PipeWire v: 0.3.48
* [LG Gram 16 2-in-1 2023 - ArchWiki](https://wiki.archlinux.org/title/LG_Gram_16_2-in-1_2023)
* [HW probe of LG Electronics 16T90R-K.ADB9U1 #e5dedec56d](https://linux-hardware.org/?probe=e5dedec56d)
* alsa-info on [alsa-project.org/db](http://alsa-project.org/db/?f=ab22ceeafd06f921c5d5ac6ff053cbdef77cbee5)
