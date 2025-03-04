# Sleep at night

The computer will go to suspend mode every 10 minutes to remind you it's time to go.
The goal is to be annoying but not so much that you can't finish stuff.

```ini
tail -n +0 /etc/systemd/system/flag.*
==> /etc/systemd/system/flag.service <==
[Unit]
Description=
Wants=flag.timer

[Service]
Type=simple
ExecStart=/usr/bin/systemctl suspend
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target

==> /etc/systemd/system/flag.timer <==
[Unit]
Description=
Requires=flag.service

[Timer]
Unit=flag.service
# Run every 10 minutes between 23:00 and 01:59
OnCalendar=*-*-* 00,01,23:00/10:00
# Prevent running missed events on boot
Persistent=false

[Install]
WantedBy=timers.target
```

install

```sh
sudo systemctl daemon-reload                 
```

monitoring
```sh
| locate flag.timer
/etc/systemd/system/flag.timer
/etc/systemd/system/timers.target.wants/flag.timer

| systemctl list-timers --all
NEXT                                 LEFT LAST                              PASSED UNIT                           ACTIVATES                       
Tue 2025-03-04 23:50:00 CET          6min Tue 2025-03-04 23:40:10 CET 2min 56s ago flag.timer                     flag.service
```
