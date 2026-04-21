#!/usr/bin/env bash
# awesome-mac-mini-homeserver - stack installer
# Usage: ./install.sh  (interactive)
#        ./install.sh agentic|media|selfhosted|all  (non-interactive)

set -euo pipefail

# ---- colors ----
if [[ -t 1 ]]; then
    BOLD=$'\033[1m'; DIM=$'\033[2m'; RESET=$'\033[0m'
    RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'
    BLUE=$'\033[34m'; MAGENTA=$'\033[35m'; CYAN=$'\033[36m'
else
    BOLD=""; DIM=""; RESET=""; RED=""; GREEN=""; YELLOW=""; BLUE=""; MAGENTA=""; CYAN=""
fi

log()   { printf "%s[+]%s %s\n" "$GREEN" "$RESET" "$*"; }
warn()  { printf "%s[!]%s %s\n" "$YELLOW" "$RESET" "$*"; }
err()   { printf "%s[x]%s %s\n" "$RED" "$RESET" "$*" >&2; }
step()  { printf "\n%s==>%s %s%s%s\n" "$CYAN" "$RESET" "$BOLD" "$*" "$RESET"; }

banner() {
    cat <<'EOF'

     +------------------------------------------------------------+
     |                                                            |
     |        AWESOME  MAC  MINI  HOME  SERVER  INSTALLER         |
     |                                                            |
     |         Agentic AI  -  Media  -  Self-Hosted Apps          |
     |                                                            |
     +------------------------------------------------------------+

EOF
}

# ---- preflight ----

require_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        err "This installer runs on macOS only. Detected: $(uname)"
        exit 1
    fi
    local arch
    arch=$(uname -m)
    if [[ "$arch" == "arm64" ]]; then
        log "Apple Silicon detected ($arch)"
    else
        warn "Intel Mac detected ($arch). Some entries tagged [AS] will be skipped."
    fi
}

require_brew() {
    if command -v brew &>/dev/null; then
        log "Homebrew already installed: $(brew --version | head -1)"
    else
        warn "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

ensure_docker() {
    if command -v docker &>/dev/null && docker info &>/dev/null; then
        log "Docker engine reachable"
        return 0
    fi
    warn "Docker not running. Recommend installing OrbStack (lightweight) or Docker Desktop."
    read -r -p "  Install OrbStack via Homebrew Cask? [Y/n] " ans
    case "${ans:-y}" in
        [yY]*|"") brew install --cask orbstack ;;
        *) err "Docker is required for stacks with [D] tag. Aborting container steps."; return 1 ;;
    esac
}

brew_install() {
    local formula="$1"
    if brew list --formula "$formula" &>/dev/null || brew list --cask "$formula" &>/dev/null; then
        log "$formula already installed"
    else
        log "brew install $formula"
        brew install "$formula" || warn "Failed to install $formula"
    fi
}

brew_cask_install() {
    local cask="$1"
    if brew list --cask "$cask" &>/dev/null; then
        log "$cask already installed"
    else
        log "brew install --cask $cask"
        brew install --cask "$cask" || warn "Failed to install $cask"
    fi
}

# ---- stack: agentic ----
install_agentic() {
    step "Installing Agentic AI stack"

    local compose_dir="$HOME/.awesome-mac-mini/agentic"
    mkdir -p "$compose_dir"

    brew_install ollama
    brew_install whisper-cpp
    brew_install llama.cpp
    brew_cask_install lm-studio
    brew_cask_install jan
    brew_cask_install enchanted
    brew_cask_install msty

    if ! command -v npm &>/dev/null; then
        brew_install node
    fi

    log "Installing Claude Code CLI..."
    npm install -g @anthropic-ai/claude-code 2>/dev/null || warn "Claude Code install failed"

    log "Installing Aider via pip..."
    if command -v pipx &>/dev/null; then
        pipx install aider-chat 2>/dev/null || warn "Aider install failed"
    else
        brew_install pipx
        pipx ensurepath
        pipx install aider-chat 2>/dev/null || warn "Aider install failed"
    fi

    # Start Ollama service
    log "Starting Ollama..."
    brew services start ollama 2>/dev/null || true

    # Pull a starter model
    log "Pulling llama3.2:3b (approx 2 GB). Press Ctrl+C to skip."
    sleep 2
    ollama pull llama3.2:3b || warn "Model pull failed, run 'ollama pull llama3.2:3b' later"

    # Open WebUI + Langfuse via docker compose
    if ensure_docker; then
        cat > "$compose_dir/compose.yml" <<'YAML'
services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    restart: unless-stopped
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://host.docker.internal:11434
    volumes:
      - open-webui:/app/backend/data
    extra_hosts:
      - "host.docker.internal:host-gateway"

  langfuse:
    image: langfuse/langfuse:latest
    container_name: langfuse
    restart: unless-stopped
    ports:
      - "3010:3000"
    environment:
      - DATABASE_URL=postgresql://postgres:postgres@langfuse-db:5432/postgres
      - NEXTAUTH_SECRET=change-me-$(date +%s)
      - SALT=change-me-salt
      - NEXTAUTH_URL=http://localhost:3010
    depends_on:
      - langfuse-db

  langfuse-db:
    image: postgres:16-alpine
    container_name: langfuse-db
    restart: unless-stopped
    environment:
      - POSTGRES_PASSWORD=postgres
    volumes:
      - langfuse-db:/var/lib/postgresql/data

volumes:
  open-webui:
  langfuse-db:
YAML
        log "Starting Open WebUI + Langfuse..."
        (cd "$compose_dir" && docker compose up -d)
    fi

    step "Agentic stack ready"
    echo "  Ollama API          http://localhost:11434"
    echo "  Open WebUI          http://localhost:3000"
    echo "  Langfuse            http://localhost:3010"
    echo "  Claude Code         run: claude"
    echo "  Aider               run: aider"
    echo "  Jan / LM Studio     launch from Applications"
}

# ---- stack: media ----
install_media() {
    step "Installing Media Server stack"

    local compose_dir="$HOME/.awesome-mac-mini/media"
    mkdir -p "$compose_dir"/{config/{sonarr,radarr,prowlarr,bazarr,qbittorrent,jellyfin},media/{movies,tv,downloads}}

    brew_cask_install jellyfin
    brew_cask_install transmission

    if ! ensure_docker; then
        warn "Docker required for *arr stack. Installed native apps only."
        return
    fi

    cat > "$compose_dir/compose.yml" <<YAML
services:
  sonarr:
    image: lscr.io/linuxserver/sonarr:latest
    container_name: sonarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - ./config/sonarr:/config
      - ./media:/media
    ports:
      - "8989:8989"
    restart: unless-stopped

  radarr:
    image: lscr.io/linuxserver/radarr:latest
    container_name: radarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - ./config/radarr:/config
      - ./media:/media
    ports:
      - "7878:7878"
    restart: unless-stopped

  prowlarr:
    image: lscr.io/linuxserver/prowlarr:latest
    container_name: prowlarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - ./config/prowlarr:/config
    ports:
      - "9696:9696"
    restart: unless-stopped

  bazarr:
    image: lscr.io/linuxserver/bazarr:latest
    container_name: bazarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - ./config/bazarr:/config
      - ./media:/media
    ports:
      - "6767:6767"
    restart: unless-stopped

  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
      - WEBUI_PORT=8080
    volumes:
      - ./config/qbittorrent:/config
      - ./media/downloads:/downloads
    ports:
      - "8080:8080"
      - "6881:6881"
      - "6881:6881/udp"
    restart: unless-stopped
YAML

    log "Starting *arr media stack..."
    (cd "$compose_dir" && docker compose up -d)

    step "Media stack ready"
    echo "  Jellyfin (native)   open -a Jellyfin"
    echo "  Sonarr              http://localhost:8989"
    echo "  Radarr              http://localhost:7878"
    echo "  Prowlarr            http://localhost:9696"
    echo "  Bazarr              http://localhost:6767"
    echo "  qBittorrent         http://localhost:8080 (user admin / pass adminadmin)"
    echo "  Library root        $compose_dir/media"
}

# ---- stack: self-hosted ----
install_selfhosted() {
    step "Installing Self-Hosted Productivity stack"

    local compose_dir="$HOME/.awesome-mac-mini/selfhosted"
    mkdir -p "$compose_dir"/data/{vaultwarden,immich,paperless,gitea,homepage}

    if ! ensure_docker; then
        err "Docker required for self-hosted stack."
        return 1
    fi

    cat > "$compose_dir/compose.yml" <<'YAML'
services:
  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    restart: unless-stopped
    environment:
      - DOMAIN=http://localhost:8222
      - SIGNUPS_ALLOWED=true
    volumes:
      - ./data/vaultwarden:/data
    ports:
      - "8222:80"

  paperless-redis:
    image: redis:7-alpine
    restart: unless-stopped

  paperless:
    image: ghcr.io/paperless-ngx/paperless-ngx:latest
    container_name: paperless
    restart: unless-stopped
    depends_on:
      - paperless-redis
    environment:
      - PAPERLESS_REDIS=redis://paperless-redis:6379
      - PAPERLESS_URL=http://localhost:8777
      - PAPERLESS_SECRET_KEY=change-me
      - PAPERLESS_TIME_ZONE=America/New_York
    volumes:
      - ./data/paperless/data:/usr/src/paperless/data
      - ./data/paperless/media:/usr/src/paperless/media
      - ./data/paperless/export:/usr/src/paperless/export
      - ./data/paperless/consume:/usr/src/paperless/consume
    ports:
      - "8777:8000"

  gitea:
    image: gitea/gitea:latest
    container_name: gitea
    restart: unless-stopped
    environment:
      - USER_UID=1000
      - USER_GID=1000
    volumes:
      - ./data/gitea:/data
    ports:
      - "3001:3000"
      - "2222:22"

  homepage:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: homepage
    restart: unless-stopped
    volumes:
      - ./data/homepage:/app/config
    ports:
      - "7575:3000"
YAML

    log "Starting self-hosted stack..."
    (cd "$compose_dir" && docker compose up -d)

    step "Self-hosted stack ready"
    echo "  Vaultwarden         http://localhost:8222"
    echo "  Paperless-ngx       http://localhost:8777"
    echo "  Gitea               http://localhost:3001"
    echo "  Homepage dashboard  http://localhost:7575"
    echo ""
    echo "  Next step - protect these with Tailscale Serve or Caddy + your domain."
}

# ---- ui ----
menu() {
    cat <<EOF

${BOLD}Pick a stack to install${RESET} (numbers separated by commas, e.g. ${CYAN}1,3${RESET} or ${CYAN}all${RESET}):

   ${BOLD}1${RESET}  ${MAGENTA}Agentic AI${RESET}          Ollama, Claude Code, Aider, Open WebUI, Langfuse,
                          Whisper.cpp, Jan, LM Studio, Enchanted, Msty

   ${BOLD}2${RESET}  ${BLUE}Media Server${RESET}        Jellyfin (native), Sonarr, Radarr, Prowlarr,
                          Bazarr, qBittorrent, Transmission

   ${BOLD}3${RESET}  ${GREEN}Self-Hosted Apps${RESET}    Vaultwarden, Paperless-ngx, Gitea,
                          Homepage dashboard

   ${DIM}q  Quit${RESET}

EOF
}

run_choice() {
    local choice="$1"
    [[ "$choice" == "all" ]] && choice="1,2,3"
    IFS=',' read -ra picks <<< "$choice"
    for p in "${picks[@]}"; do
        p="${p// /}"
        case "$p" in
            1|agentic)     install_agentic ;;
            2|media)       install_media ;;
            3|selfhosted)  install_selfhosted ;;
            q|Q|quit|exit) exit 0 ;;
            *) warn "Unknown choice: '$p'" ;;
        esac
    done
}

main() {
    clear
    banner
    require_macos
    require_brew

    if [[ $# -gt 0 ]]; then
        run_choice "$1"
    else
        menu
        read -r -p "${BOLD}>${RESET} " choice
        echo ""
        run_choice "${choice:-1}"
    fi

    step "Done"
    echo ""
    echo "  Docs   ${CYAN}https://github.com/momenbasel/awesome-mac-mini-homeserver${RESET}"
    echo "  Issues ${CYAN}https://github.com/momenbasel/awesome-mac-mini-homeserver/issues${RESET}"
    echo ""
    echo "  Tip: put the mini in a closet. Use ${BOLD}Tailscale${RESET} + ${BOLD}pmset${RESET}:"
    echo "       ${DIM}sudo pmset -a sleep 0 disksleep 0 womp 1 autorestart 1${RESET}"
    echo ""
}

main "$@"
