# Power management

A Mac mini set up as a home server needs different power settings than a desktop.

## One-shot hardening

```bash
sudo pmset -a sleep 0              # never sleep
sudo pmset -a disksleep 0          # never spin down internal SSD
sudo pmset -a displaysleep 10      # OK to blank the display (saves nothing with no display attached)
sudo pmset -a womp 1               # wake on magic packet
sudo pmset -a autorestart 1        # reboot after power failure
sudo pmset -a powernap 0           # disable power nap (unpredictable with launchd workers)
sudo pmset -a hibernatemode 0      # avoid writing RAM to disk on sleep
sudo pmset -a standby 0            # disable standby
sudo pmset -a tcpkeepalive 1       # keep TCP alive during brief low-power periods
```

Verify:

```bash
pmset -g
```

## UPS integration

Install NUT to cleanly shut down on battery exhaustion:

```bash
brew install nut
sudo nut-scanner -U                # detect your UPS
# configure /opt/homebrew/etc/nut/ups.conf with the model found above
sudo brew services start nut
```

## Live power telemetry

```bash
sudo powermetrics --samplers cpu_power,gpu_power,ane_power -i 1000
# or for a prettier TUI
brew install asitop
asitop
```

## Auto-login so the box comes back after reboot

System Settings -> Users & Groups -> Automatic login. Needed so launchd user agents (Ollama, Claude Code workers) restart without manual intervention.

## Wake-on-LAN

Enable `womp 1` (done above), then:

```bash
# From another machine on the LAN
wakeonlan <mini-mac-address>
```
