# GlobalProtect override

## Desired state

Even after GlobalProtect is 'aagressively' stopped, DNS resolver #1 must point to the correct IP e.g. at home: 8.8.8.8 (Google) ; at work, some coporate IP (e.g. 10.0.0.0/8 Private range)

### Temporary aproach

If GlobalProtect and Netskope are fighting over who gets to write to configd and leaving you with 8.8.8.8, take the wheel manually. Force your Wi-Fi interface (en0) to use the corporate DNS as its primary fallback:

```sh
sudo networksetup -setdnsservers Wi-Fi <IP>
```

*Once you do this, you will need to revert it to Empty when you leave the corporate network ecosystem, or your home Wi-Fi won't resolve anything:*

`sudo networksetup -setdnsservers Wi-Fi Empty`


## 1. Problem

Symptom: after network change, `dig google.com` fails.

Due to enterprise MDM (Mobile Device Management) watchdogs like Jamf or native launchd keep-alive loops. If your IT department has a configuration profile enforcing those daemons, launchctl unload will absolutely get overridden and rejected a few seconds later.

The services also can't be removed without disabling SIP. In that specific adversarial context, applying `chmod -x` to the application directory is the only solution: by stripping execute permissions from the directory, you are breaking the watchdog’s ability to even look inside the folder to restart the binary.
But it’s a sledgehammer approach that leaves system configuration daemons (configd, mDNSResponder) confused.

Corporate security suites like Netskope utilize **macOS System Extensions** (`com.apple.NetworkExtension`). These run directly inside the kernel-level network loop. When you killed the parent GUI application, the system extension remained active in memory and left corporate dynamic store overrides (`scutil` keys) trapped in the system configuration daemon (`configd`). This resulted in a **DNS black hole**: your routing tables were fine, but your resolver chain was completely hijacked.

---

## 2. Investigation Logs & Critical Meanings

### Command Group A: Routing State Analysis

* `sudo route get default`
* `netstat -rn`
* **Critical Output:** `gateway: 192.168.1.1`, `interface: en0`, `Destination: default -> Gateway: 192.168.1.1`.
* **Meaning:** Your physical IP routing layer was completely normal. Traffic knew exactly how to reach your home router. The problem was strictly isolated to name resolution.

### Command Group B: Resolver Chain Diagnostics

* `scutil --dns`
* **Critical Output:** * `resolver #1` -> `nameserver[0] : <corporate-ip>` (`order : 101200`)
* `resolver #2` -> `nameserver[2] : 192.168.1.1` (`order : 200000`)

* **Meaning:** macOS prioritizes resolvers based on the `order` index. The corporate DNS was pinned at the top priority index. Your home router resolver was pushed to second place, meaning all internet lookup requests timed out searching for a corporate IP that does not exist on your home network.

### Command Group C: Dynamic Store and Architecture Verification

* `echo "list .*DNS.*" | scutil`
* `sudo systemextensionsctl uninstall <ID>`
* **Critical Output:** * `subKey [3] = State:/Network/Service/4416AD74-.../DNS`
* `Error: This tool cannot be used if System Integrity Protection is enabled.`


* **Meaning:** Netskope registered isolated dynamic store GUID profiles directly into the network stack. Because System Integrity Protection (SIP) blocks user-space execution forces from removing kernel-level extensions, the extension stayed alive, holding those dynamic store keys hostage even though the user-space apps were dead.

---

## 3. A Resilient `vpn-reset.sh`

This script handles the issue programmatically. It applies the brute-force binary lockout, programmatically discovers and purges every non-DHCP corporate registry key from `scutil`, cleans up legacy network setup clutter, and forces a dynamic state override to bypass any lingering kernel-level extension traps.

```bash
#!/bin/bash
# ==============================================================================
# VPN-RESET.SH: Resilient Corporate Network Stack Purge & DHCP Restore
# ==============================================================================

# Ensure script runs with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "[-] This script requires administrative privileges. Re-running with sudo..."
  exec sudo "$0" "$@"
fi

echo "[*] 1. Executing Binary Blockade..."
# Block execution directories to counter MDM watchdog daemon triggers
chmod -x /Applications/Netskope\ Client.app /Applications/GlobalProtect.app 2>/dev/null
killall -9 GlobalProtect "Netskope Client" PanGPS 2>/dev/null

echo "[*] 2. Programmatically Purging Corporate DNS Keys from Dynamic Store..."
# Extract all runtime DNS configurations, protecting only the core system DHCP map
STALE_KEYS=$(echo "list State:/Network/.*DNS.*" | scutil | awk '{print $3}' | grep -E "Service|Global" | grep -v "DHCP-en0")

if [ -n "$STALE_KEYS" ]; then
    scutil <<EOF
open
$(for key in $STALE_KEYS; do echo "remove $key"; done)
close
EOF
    echo "[+] Vaporized stale corporate scutil bindings."
else
    echo "[+] Dynamic store is clear of standard stale keys."
fi

echo "[*] 3. Sweeping Polluted Network Setup Interfaces..."
# Loop through all network services, destroying obsolete or profile-injected entities
networksetup -listallnetworkservices | grep -v "\*" | while read -r service; do
    if [[ "$service" =~ "Wi-Fi" || "$service" =~ "AirPort" || "$service" =~ "Bluetooth" ]]; then
        # Force native interfaces back to unmanaged DHCP mode
        networksetup -setdnsservers "$service" Empty 2>/dev/null
        continue
    fi
    echo "[-] Removing ghost/polluted service: [$service]"
    networksetup -removenetworkservice "$service" 2>/dev/null
done

echo "[*] 4. Executing Dictator Override Against System Extensions..."
# Force a definitive global resolver map directly to the hardware layer,
# overriding any silent interceptions by the active kernel extension.
scutil <<EOF
open
d.init
d.add ServerAddresses * 192.168.1.1 1.1.1.1 8.8.8.8
set State:/Network/Global/DNS
close
EOF

echo "[*] 5. Cycling Network Interface Stack..."
# Force the OS to tear down dynamic connection tables and rebuild from zero
ipconfig set en0 NONE 2>/dev/null
sleep 1
ipconfig set en0 DHCP 2>/dev/null

# Flush kernel-level DNS daemon cache
killall -HUP mDNSResponder

echo "[=] Execution Complete. Network infrastructure reverted to pristine state."

```

To start

```sh
#!/bin/bash

echo "--- Re-enabling Corporate Binaries ---"
# 1. Restore execute permissions
sudo chmod +x /Applications/GlobalProtect.app /Applications/Netskope\ Client.app 2>/dev/null

# 2. Use 'open' instead of raw execution so it doesn't hijack your current shell session
open -a /Applications/GlobalProtect.app
#open -a /Applications/Netskope\ Client.app 2>/dev/null

echo "=== VPN Services Signaled to Start ==="
```
