
  
All of these point to a set of hda-driver commands that did not work for me
  * thesofproject/linux#4055 *Samsung Galaxy Book2 Pro 360 no sound through speaker*
  * thesofproject/linux#4363 *No sound on LG Gram 17 inch from 2023 (model: 17Z90R)*

This is for tracing windows driver calls:

* (2021) [How to sniff verbs from a Windows sound driver · ryanprescott/realtek-verb-tools Wiki · GitHub](https://github.com/ryanprescott/realtek-verb-tools/wiki/How-to-sniff-verbs-from-a-Windows-sound-driver)
* (2018) [Setup and usage of the program · Conmanx360/QemuHDADump Wiki · GitHub](https://github.com/Conmanx360/QemuHDADump/wiki/Setup-and-usage-of-the-program)
* (2018 fork) [GitHub - abridgewater/QemuHDADump: Dumps HDA verbs from the CORB buffer of a virtual machine. Useful for reverse engineering drivers on different operating systems.](https://github.com/abridgewater/QemuHDADump)
* [kernel bug 207423 c#24](https://bugzilla.kernel.org/show_bug.cgi?id=207423#c24) *930MBE, Realtek ALC298, Speaker, Internal, No sound on internal speakers* has additional explanations on the fork

Bug 207423 led to patches like [LKML: Greg Kroah-Hartman: PATCH 5.19 145/155 ALSA: hda/realtek: Add speaker AMP init for Samsung laptops with ALC298](https://lkml.org/lkml/2022/9/6/964)
which should have ended on/around linux 5.10.

For ref the current (Sep23) version of the patched file is [patch_realtek.c - Linux source code (v6.6-rc2) - Bootlin](https://elixir.bootlin.com/linux/v6.6-rc2/source/sound/pci/hda/patch_realtek.c)


The following was used to try the samsung [hda-verb](https://www.kernel.org/doc/html/latest/sound/hd-audio/notes.html#hda-verb) workaround:

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

and the following to activate the kernel patch as per [set up the audio card in Samsung Galaxy Book - Manjaro Linux](https://forum.manjaro.org/t/howto-set-up-the-audio-card-in-samsung-galaxy-book/37090/36) (more doc: [Early patching - More Notes on HD-Audio Driver — The Linux Kernel documentation](https://www.kernel.org/doc/html/latest/sound/hd-audio/notes.html#early-patching):

```sh
sudo tee /etc/modprobe.d/audio-fix-alc298--samsung-headphone.conf <<< 'options snd-hda-intel model=alc298-samsung-amp'
```

...without success after reboots.
