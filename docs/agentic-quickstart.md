# Agentic Quick Start

Turn a Mac mini into a 24/7 local agent host in about 20 minutes.

## Prerequisites

- Apple Silicon Mac mini with at least 16 GB unified memory (32 GB+ recommended for 13B models).
- macOS Sonoma or later.
- Admin account with auto-login enabled.
- A static LAN IP or Tailscale installed.

## 1. Base hardening

```bash
# Never sleep, auto-restart on power loss, wake on network
sudo pmset -a sleep 0 disksleep 0 displaysleep 10 womp 1 autorestart 1 powernap 0

# Keep Terminal's shell alive forever
caffeinate -disu &
```

## 2. Install core stack

```bash
./install.sh agentic
```

That pulls Homebrew, Ollama, llama.cpp, whisper-cpp, Jan, LM Studio, Enchanted, Msty, Claude Code CLI, Aider, Open WebUI, and Langfuse.

## 3. Pull a model for your RAM tier

| Mac mini RAM | Recommended starter model | Size |
|---|---|---|
| 16 GB | `llama3.2:3b` | 2 GB |
| 24 GB | `qwen2.5:14b` | 9 GB |
| 32 GB | `qwen2.5:32b-q4` | 20 GB |
| 64 GB | `llama3.3:70b-q4` | 40 GB |

```bash
ollama pull qwen2.5:14b
```

## 4. Wire Claude Code to local tools

```bash
mkdir -p ~/.config/claude
cat > ~/.config/claude/mcp.json <<'JSON'
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/yourname/Work"]
    }
  }
}
JSON
```

## 5. Expose via Tailscale

```bash
brew install tailscale
sudo tailscale up
# Open WebUI becomes reachable at http://<mini>.<tailnet>.ts.net:3000
```

## 6. Run Claude Code as a scheduled worker

```bash
# ~/Library/LaunchAgents/com.you.claude-worker.plist
# Runs "claude -p 'review and summarize yesterday git log'" every morning at 8 AM.
```

Launch it:

```bash
launchctl load ~/Library/LaunchAgents/com.you.claude-worker.plist
```

## Next steps

- Add a Telegram bridge so you can message your agent from your phone.
- Hook `Langfuse` to capture every request, response, and latency.
- Add `mem0` or `Letta` for persistent memory across sessions.
- Use `n8n` or `Dagu` to orchestrate multi-step agent flows.
