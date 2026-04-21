#!/usr/bin/env bash
# time-machine-server.sh
# Turns this Mac mini into a Time Machine destination for every Mac on the LAN.
# Any Mac running macOS can then pick this disk in Settings -> Time Machine -> Add Backup Disk.
#
# Usage:
#   sudo ./time-machine-server.sh /Volumes/ExternalDrive [ShareName]
#
# Notes:
# - The external disk must be formatted APFS or HFS+ (not exFAT / NTFS).
# - macOS uses SMB + Bonjour to advertise Time Machine servers ("_smb._tcp"
#   with the "Time Machine" service flag).
# - All options here are reversible via `sudo sharing -r "ShareName"`.

set -euo pipefail

RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; CYAN=$'\033[36m'; BOLD=$'\033[1m'; RESET=$'\033[0m'
log()   { printf "%s[+]%s %s\n" "$GREEN" "$RESET" "$*"; }
warn()  { printf "%s[!]%s %s\n" "$YELLOW" "$RESET" "$*"; }
err()   { printf "%s[x]%s %s\n" "$RED" "$RESET" "$*" >&2; exit 1; }
step()  { printf "\n%s==>%s %s%s%s\n" "$CYAN" "$RESET" "$BOLD" "$*" "$RESET"; }

# ---- preflight ----

[[ "$(uname)" == "Darwin" ]] || err "This tool only runs on macOS."
[[ $EUID -eq 0 ]] || err "Please re-run with sudo (needs to create shares and edit /etc/smb.conf)."

DISK="${1:-}"
SHARE_NAME="${2:-TimeMachine}"

if [[ -z "$DISK" ]]; then
    cat <<EOF

${BOLD}Usage:${RESET} sudo $0 <disk-path> [share-name]

${BOLD}Example:${RESET}
  sudo $0 /Volumes/Backup
  sudo $0 /Volumes/Backup "Family-Time-Machine"

Available volumes right now:
EOF
    diskutil list | grep -E "^/dev/|Apple_HFS|Apple_APFS" | head -20
    exit 1
fi

[[ -d "$DISK" ]] || err "Disk path '$DISK' not found. Is the external drive mounted?"

FS_TYPE=$(diskutil info "$DISK" 2>/dev/null | awk -F: '/File System Personality/ {gsub(/^ +/,"",$2); print $2}' || true)
case "$FS_TYPE" in
    *APFS*|*HFS*)
        log "Filesystem OK: $FS_TYPE"
        ;;
    *)
        warn "Disk filesystem reports '$FS_TYPE'."
        warn "Time Machine requires APFS or HFS+. Reformat the drive in Disk Utility first."
        read -rp "Continue anyway? [y/N] " ans
        [[ "${ans:-n}" =~ ^[Yy]$ ]] || exit 1
        ;;
esac

# ---- create share ----
step "Creating SMB share '$SHARE_NAME' for $DISK"

if sharing -l | grep -q "name:\s*$SHARE_NAME"; then
    log "Share '$SHARE_NAME' already exists. Updating..."
    sharing -r "$SHARE_NAME" || true
fi

# Flags: -n share-name  -s 001 (SMB only, no AFP/FTP)  -g 011 (R/W for everyone)
# -S "" (same name for SMB)  -t 1 (enable Time Machine)
sharing -a "$DISK" -n "$SHARE_NAME" -s 001 -g 011 -S "$SHARE_NAME" -t 1 \
    && log "SMB share created and flagged as Time Machine destination"

# ---- enable SMB server ----
step "Enabling SMB file sharing service"
launchctl load -w /System/Library/LaunchDaemons/com.apple.smbd.plist 2>/dev/null || true
defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server EnabledServices -array disk
log "smbd running"

# ---- Time Machine destination advertisement ----
step "Registering disk as a Time Machine destination"
# Tell Time Machine the volume is OK as a network backup destination
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1
# Allow TM backups to the share
sudo tmutil setdestination -a "smb://$(scutil --get LocalHostName).local/$SHARE_NAME" 2>/dev/null \
    || warn "Could not auto-register local destination. Clients can still discover it via Bonjour."

# ---- (optional) reserve disk space so one Mac does not eat everything ----
QUOTA_GB="${QUOTA_GB:-}"
if [[ -n "$QUOTA_GB" ]]; then
    step "Setting per-backup quota to ${QUOTA_GB} GB"
    defaults write /Library/Preferences/com.apple.TimeMachine MaxSize -int "$((QUOTA_GB * 1024))"
fi

# ---- Bonjour advertisement ----
step "Advertising via Bonjour so other Macs see it in Finder"
HOST=$(scutil --get ComputerName)
cat <<EOF

${BOLD}Share is live.${RESET}

From any other Mac on this network:
  1) Open ${CYAN}System Settings  ->  General  ->  Time Machine${RESET}
  2) Click ${CYAN}Add Backup Disk...${RESET}
  3) Pick:  ${BOLD}$SHARE_NAME${RESET} on "${HOST}"
  4) Sign in with the Mac mini's user account password.

Or connect directly in Finder with:
  ${CYAN}smb://$(scutil --get LocalHostName).local/$SHARE_NAME${RESET}

To see who is currently backing up:
  ${CYAN}sudo tmutil listbackups -a${RESET}

To remove the share later:
  ${CYAN}sudo sharing -r "$SHARE_NAME"${RESET}

EOF
