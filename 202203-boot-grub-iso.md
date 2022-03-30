# How to boot from ISO on a locked-down system with grub.

First go to grub command-line.
If grub is secured by a password you may need to (temporarily) remove security.

Inspired from https://help.ubuntu.com/community/Grub2/ISOBoot

```
ls
set root='hd0,msdos1'
ls /
set isof=/jammy-desktop-amd64.iso
loopback loop $isof
rmmod tpm
linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=$isofile noprompt noeject
initrd (loop)/casper/initrd
```

Note: this still does not work for me :-(
