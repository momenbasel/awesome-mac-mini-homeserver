<p align="center">
  <img src="assets/banner-gemini.png" alt="Awesome Mac mini Home Server" width="100%">
</p>

# Awesome Mac mini Home Server [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

> A curated list of tools, guides, and projects for running an Apple Silicon Mac mini as a 24/7 home server, with agentic AI as the headline focus.

## What is this, in plain English?

You buy a Mac mini. You stick it in a closet. It quietly runs, forever, doing useful things for you:

- **Your personal AI.** It runs ChatGPT-style assistants locally, so your prompts never leave your home.
- **Your photo library.** Like iCloud, but you own it.
- **Your password vault.** Like 1Password, but you own it.
- **Your media server.** Like Netflix, with your own shows.
- **Your smart home brain.** Home Assistant, HomeKit, Matter - all in one place.
- **Your personal automation.** Tell it "every morning at 8am, read my emails and summarize them" - it does that.

This list is the map. It tells you **which tools are good**, **what they do**, and gives you a **one-command installer** to get started.

If a tag like `[D]` confuses you, check the [Legend](#legend). If you just want to get going, jump to [Quick Start](#quick-start).

<div align="center">

**[Agentic AI](#agentic-ai)**  ·  **[Self-Hosted Apps](#self-hosted-apps)**  ·  **[Media Servers](#media-servers)**  ·  **[Smart Home](#smart-home)**  ·  **[Quick Start](#quick-start)**

[![License: CC0-1.0](https://img.shields.io/badge/License-CC0--1.0-lightgrey.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Lint](https://github.com/momenbasel/awesome-mac-mini-homeserver/actions/workflows/lint.yml/badge.svg)](https://github.com/momenbasel/awesome-mac-mini-homeserver/actions/workflows/lint.yml)
[![Last Commit](https://img.shields.io/github/last-commit/momenbasel/awesome-mac-mini-homeserver)](https://github.com/momenbasel/awesome-mac-mini-homeserver/commits/main)

</div>

---

## Why a Mac mini?

Apple Silicon Mac mini is the highest performance-per-watt home server you can buy. Unified memory, Metal and ANE acceleration, silent fans, and native macOS daemons make it the ideal always-on host for local agents, self-hosted services, and home automation.

| Metric | Mac mini M4 | Typical x86 SFF |
|---|---|---|
| Idle power | 4-7 W | 15-35 W |
| Peak power | 65 W | 120-200 W |
| Unified memory ceiling | 64 GB | 64-128 GB (discrete, slow GPU path) |
| LLM inference (70B Q4) | Runs on 64 GB tier | Needs dedicated GPU |
| Fan noise at idle | Inaudible | Audible |
| Form factor | 5 x 5 x 2 in | Typically 8+ in |
| Built-in server daemons | SMB, AFP, HomeKit, Time Machine, AirPlay | None |

---

## Architecture at a glance

```mermaid
flowchart LR
    subgraph Mini["Mac mini (24/7 host)"]
        direction TB
        O[Ollama / MLX / llama.cpp]
        C[Claude Code / Aider]
        MCP[MCP servers]
        L[launchd + cron]
        D[Docker / OrbStack]
        HA[Home Assistant]
        TM[Time Machine server]
        O --> C
        C --> MCP
        L --> C
        D --> HA
    end
    Phone[iPhone / iPad] -->|Shortcuts| L
    Chat[Telegram / Slack] -->|Bridge| C
    Macs[Other Macs] -->|Tailscale| Mini
    Mini -->|HomeKit| IoT[IoT devices]
    Mini -->|SMB| NAS[External storage]
```

---

## Quick Start

Install a curated stack with the included CLI. Pick Agentic AI, Media Server, or Self-Hosted Productivity:

```bash
curl -fsSL https://raw.githubusercontent.com/momenbasel/awesome-mac-mini-homeserver/main/install.sh -o install.sh
chmod +x install.sh
./install.sh
```

Review [`install.sh`](install.sh) before running. Idempotent: safe to re-run. See [docs/agentic-quickstart.md](docs/agentic-quickstart.md) for the opinionated agentic build.

```text
+------------------------------------------------------------+
|                                                            |
|        AWESOME  MAC  MINI  HOME  SERVER  INSTALLER         |
|                                                            |
|         Agentic AI  -  Media  -  Self-Hosted Apps          |
|                                                            |
+------------------------------------------------------------+

Pick a stack to install (numbers separated by commas, e.g. 1,3 or all):

   1  Agentic AI          Ollama, Claude Code, Aider, Open WebUI, Langfuse,
                          Whisper.cpp, Jan, LM Studio, Enchanted, Msty

   2  Media Server        Jellyfin (native), Sonarr, Radarr, Prowlarr,
                          Bazarr, qBittorrent, Transmission

   3  Self-Hosted Apps    Vaultwarden, Paperless-ngx, Gitea,
                          Homepage dashboard
```

Non-interactive: `./install.sh agentic` / `media` / `selfhosted` / `all`.

### Stack components at a glance

**Agentic AI**
![Ollama](https://img.shields.io/badge/Ollama-000000?style=for-the-badge&logo=ollama&logoColor=white)
![Claude](https://img.shields.io/badge/Claude_Code-D97706?style=for-the-badge&logo=anthropic&logoColor=white)
![OpenWebUI](https://img.shields.io/badge/Open_WebUI-000000?style=for-the-badge&logo=openai&logoColor=white)
![Langfuse](https://img.shields.io/badge/Langfuse-0A0A0A?style=for-the-badge)
![Whisper](https://img.shields.io/badge/whisper.cpp-412991?style=for-the-badge&logo=openai&logoColor=white)

**Media Server**
![Jellyfin](https://img.shields.io/badge/Jellyfin-00A4DC?style=for-the-badge&logo=jellyfin&logoColor=white)
![Sonarr](https://img.shields.io/badge/Sonarr-2596BE?style=for-the-badge)
![Radarr](https://img.shields.io/badge/Radarr-FFCA28?style=for-the-badge)
![Prowlarr](https://img.shields.io/badge/Prowlarr-E37100?style=for-the-badge)
![qBittorrent](https://img.shields.io/badge/qBittorrent-2F67BA?style=for-the-badge&logo=qbittorrent&logoColor=white)

**Self-Hosted Apps**
![Vaultwarden](https://img.shields.io/badge/Vaultwarden-175DDC?style=for-the-badge&logo=bitwarden&logoColor=white)
![Paperless](https://img.shields.io/badge/Paperless-17541F?style=for-the-badge)
![Gitea](https://img.shields.io/badge/Gitea-609926?style=for-the-badge&logo=gitea&logoColor=white)
![Homepage](https://img.shields.io/badge/Homepage-0F172A?style=for-the-badge)

---

## Legend

Each entry carries one or more badges so you can see at a glance what it runs on and how it ships.

| Badge | Meaning |
|---|---|
| ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) | Runs only on Apple Silicon (M1/M2/M3/M4). Not compatible with Intel Macs. |
| ![Intel](https://img.shields.io/badge/Intel-0071C5?style=flat-square&logo=intel&logoColor=white) | Intel Mac only. |
| ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) | Universal binary - works on both Apple Silicon and Intel. |
| ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) | Ships as a native macOS app or CLI (Homebrew, `.app`, or signed binary). |
| ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) | Runs in a Docker container (use OrbStack, Colima, or Docker Desktop). |
| ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square) | Paid or freemium - free tier may exist but full use often needs a license. |

---

## Contents

- [Agentic AI](#agentic-ai)
  - [Apple Silicon optimized (MLX / CoreML / ANE)](#apple-silicon-optimized-mlx--coreml--ane)
  - [Local LLM runtimes](#local-llm-runtimes)
  - [Agentic frameworks](#agentic-frameworks)
  - [Coding agents and AI IDEs](#coding-agents-and-ai-ides)
  - [Agent sandboxes](#agent-sandboxes)
  - [MCP servers](#mcp-servers)
  - [Agent gateways and LLMOps](#agent-gateways-and-llmops)
  - [Tool and integration platforms](#tool-and-integration-platforms)
  - [Document ingestion](#document-ingestion)
  - [Agent memory and RAG](#agent-memory-and-rag)
  - [Vector databases](#vector-databases)
  - [Browser and computer-use agents](#browser-and-computer-use-agents)
  - [Voice and multimodal agents](#voice-and-multimodal-agents)
  - [Agent UIs](#agent-uis)
  - [Orchestration and eventing](#orchestration-and-eventing)
  - [Observability](#observability)
  - [Image and video agents](#image-and-video-agents)
  - [Agent bridges](#agent-bridges)
- [Hardware](#hardware)
- [OS and base setup](#os-and-base-setup)
- [Remote access](#remote-access)
- [Containers and virtualization](#containers-and-virtualization)
- [Media servers](#media-servers)
- [Storage and NAS](#storage-and-nas)
- [Self-hosted apps](#self-hosted-apps)
- [Smart home](#smart-home)
- [Ad blocking and DNS](#ad-blocking-and-dns)
- [Reverse proxy and TLS](#reverse-proxy-and-tls)
- [Monitoring and observability](#monitoring-and-observability)
- [Automation and scheduling](#automation-and-scheduling)
- [Development environments](#development-environments)
- [Backup](#backup)
- [Security](#security)
- [Audio and AirPlay](#audio-and-airplay)
- [Game streaming](#game-streaming)
- [Torrents and Usenet](#torrents-and-usenet)
- [Photo and video](#photo-and-video)
- [Databases](#databases)
- [Dashboards](#dashboards)
- [Power and thermals](#power-and-thermals)
- [Bootstrap and dotfiles](#bootstrap-and-dotfiles)
- [CI/CD and build farms](#cicd-and-build-farms)
- [Networking](#networking)
- [Sleep, wake, and persistence](#sleep-wake-and-persistence)
- [CLI power tools](#cli-power-tools)
- [File transfer](#file-transfer)
- [Reference lists](#reference-lists)
- [Contributing](#contributing)

---

## Agentic AI

Mac mini is the ideal 24/7 host for local agents. Unified memory runs large models natively. Metal accelerates inference. `launchd` turns any script into an always-on worker. See [docs/ram-sizing-llm.md](docs/ram-sizing-llm.md) for model sizing per memory tier.

### Apple Silicon optimized (MLX / CoreML / ANE)

Tools that exploit the Mac mini's unique hardware - Neural Engine, Metal Performance Shaders, and unified memory - for the fastest or lowest-power inference possible.

- [CoreML Tools](https://github.com/apple/coremltools) - Convert PyTorch, TensorFlow, and ONNX models to CoreML for ANE and Metal execution. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [DiffusionKit](https://github.com/argmaxinc/DiffusionKit) - Argmax's on-device Stable Diffusion with MLX and CoreML. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [exo](https://github.com/exo-explore/exo) - Run a unified LLM cluster across multiple Apple devices at home. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [FastMLX](https://github.com/Blaizzy/fastmlx) - OpenAI-compatible high-performance server for MLX models. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [llamafile](https://github.com/Mozilla-Ocho/llamafile) - Single-binary LLM distribution with Apple Silicon acceleration. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [ml-ane-transformers](https://github.com/apple/ml-ane-transformers) - Apple's reference transformer implementation optimized for the Neural Engine. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [MLX](https://github.com/ml-explore/mlx) - Apple's array framework for Apple Silicon unified memory. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [MLX-Audio](https://github.com/Blaizzy/mlx-audio) - TTS, STT, and speech-to-speech for MLX. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [MLX-LM](https://github.com/ml-explore/mlx-lm) - Run Llama, Mistral, Qwen, Phi via MLX with 4 and 8-bit quantization. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [mlx-vlm](https://github.com/Blaizzy/mlx-vlm) - Vision-language models on MLX (LLaVA, Qwen-VL, Pixtral). ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [mlx-whisper](https://pypi.org/project/mlx-whisper/) - OpenAI Whisper ported to MLX for Apple Silicon native speed. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [swift-transformers](https://github.com/huggingface/swift-transformers) - Hugging Face Swift library for CoreML model inference. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [WhisperKit](https://github.com/argmaxinc/WhisperKit) - Argmax's CoreML-optimized Whisper with ANE acceleration. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

### Local LLM runtimes

- [GPUStack](https://github.com/gpustack/gpustack) - GPU cluster manager that auto-configures vLLM and SGLang workers across heterogeneous nodes. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Jan](https://jan.ai) - Offline local AI chat with a polished native UI. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [llama.cpp](https://github.com/ggerganov/llama.cpp) - C/C++ inference engine with first-class Metal backend. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [llama-swap](https://github.com/mostlygeek/llama-swap) - Go proxy that hot-swaps llama.cpp or any OpenAI-compatible backend on demand. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [LM Studio](https://lmstudio.ai) - GUI for GGUF models with an OpenAI-compatible headless server. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [LocalAI](https://github.com/mudler/LocalAI) - OpenAI-compatible drop-in API for local models. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Ollama](https://ollama.com) - One-command local LLM server, Metal-accelerated by default. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [SGLang](https://github.com/sgl-project/sglang) - High-performance serving framework with structured-output and radix-cache scheduling. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [vLLM](https://github.com/vllm-project/vllm) - High-throughput inference server, runs via Docker on Apple Silicon. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Agentic frameworks

- [Agno](https://github.com/agno-agi/agno) - Python runtime and AgentOS control plane for building, deploying, and operating agentic systems at scale. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [AgentScope](https://github.com/modelscope/agentscope) - Production-oriented multi-agent framework from Alibaba with built-in tool, memory, and voice abstractions. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Aider](https://aider.chat) - Terminal-native AI pair programmer with git-aware edits. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [AutoGen](https://github.com/microsoft/autogen) - Multi-agent conversation framework from Microsoft. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Claude Code](https://docs.claude.com/en/docs/claude-code) - Anthropic's terminal coding agent, scriptable via stdin and launchd. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Cline](https://cline.bot) - Autonomous coding agent for VS Code. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Continue](https://continue.dev) - Open-source AI code assistant for IDEs. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [CrewAI](https://www.crewai.com) - Role-based multi-agent orchestration framework. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [DSPy](https://github.com/stanfordnlp/dspy) - Stanford framework for programming (not prompting) LMs via compiled modules and optimizers. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Goose](https://block.github.io/goose/) - Open-source on-machine AI agent by Block. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Inngest AgentKit](https://github.com/inngest/agent-kit) - TypeScript toolkit for building multi-agent networks on Inngest's durable runtime. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [LangGraph](https://github.com/langchain-ai/langgraph) - Stateful multi-actor agent graphs. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Mastra](https://github.com/mastra-ai/mastra) - TypeScript agent framework with workflows, RAG, and evals for shipping production agents. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [mcp-agent](https://github.com/lastmile-ai/mcp-agent) - Python framework for composing agents purely out of MCP servers. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Microsoft Agent Framework](https://github.com/microsoft/agent-framework) - Enterprise successor to AutoGen with Python and .NET SDKs for multi-agent workflows. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Open Interpreter](https://www.openinterpreter.com) - Natural language interface that executes code locally. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [OpenClaw](https://github.com/openclaw/openclaw) - Open-source always-on personal AI assistant controllable via WhatsApp, Telegram, Discord, and Slack with persistent memory and 50+ integrations. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [OpenAI Agents SDK](https://github.com/openai/openai-agents-python) - Lightweight multi-agent orchestration SDK that succeeds Swarm, works with any OpenAI-compatible provider. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [OpenHands](https://github.com/All-Hands-AI/OpenHands) - Autonomous software engineer agent platform. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Pydantic AI](https://github.com/pydantic/pydantic-ai) - Type-safe Python agent framework from the Pydantic team. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [smolagents](https://github.com/huggingface/smolagents) - Minimal agent library from Hugging Face. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [VoltAgent](https://github.com/VoltAgent/voltagent) - TypeScript agent-engineering framework with optional cloud console for observability. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Fabric](https://github.com/danielmiessler/fabric) - Go CLI that applies reusable AI patterns to stdin for summarization, code review, and research. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

### Coding agents and AI IDEs

- [Bolt.diy](https://github.com/stackblitz-labs/bolt.diy) - Community fork of StackBlitz Bolt for full-stack web app generation against any LLM. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python) - Anthropic SDK for building custom agents on top of Claude Code with hooks and custom tools. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) - Open-source Google agent that brings Gemini or local models into the terminal with extensible tools. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Kilo Code](https://github.com/Kilo-Org/kilocode) - All-in-one agentic engineering platform available as VS Code extension and CLI. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [OpenAI Codex CLI](https://github.com/openai/codex) - Lightweight terminal coding agent from OpenAI, works with local OpenAI-compatible endpoints. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Roo Code](https://github.com/RooCodeInc/Roo-Code) - VS Code extension with autonomous architect, code, debug, and custom agent modes. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [SWE-agent](https://github.com/SWE-agent/SWE-agent) - Princeton/Stanford framework for LM agents that autonomously fix GitHub issues. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Void](https://github.com/voideditor/void) - Open-source Cursor alternative built on VS Code with agentic editing and any-model support. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Zed](https://github.com/zed-industries/zed) - High-performance native macOS editor with first-class agent panel, MCP, and Metal-accelerated UI. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

### Agent sandboxes

- [Daytona](https://github.com/daytonaio/daytona) - Elastic runtime that spins up isolated dev-container sandboxes for agent code execution. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [E2B](https://github.com/e2b-dev/E2B) - Open-source secure cloud sandboxes for running AI-generated code, self-hostable. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### MCP servers

- [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) - Community-curated catalog of MCP servers, the canonical discovery index. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [FastMCP](https://github.com/jlowin/fastmcp) - Pythonic framework for building MCP servers and clients with auto-generated schemas. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [GitMCP](https://github.com/idosal/git-mcp) - Remote MCP server that grounds assistants in any public GitHub repo's docs and code. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Glama MCP Registry](https://glama.ai/mcp/servers) - Directory of 20k+ MCP servers filterable by language, transport, and category. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [MCP Filesystem](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem) - Official filesystem MCP server. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [MCP GitHub](https://github.com/modelcontextprotocol/servers/tree/main/src/github) - Official GitHub MCP server. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [MCP Puppeteer](https://github.com/modelcontextprotocol/servers/tree/main/src/puppeteer) - Browser automation via MCP. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [MCP reference servers](https://github.com/modelcontextprotocol/servers) - Official reference implementations (filesystem, git, fetch, memory, sequential-thinking). ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [mcp.run](https://www.mcp.run) - Registry and runtime for portable MCP servlets. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Smithery](https://smithery.ai) - Largest open marketplace of MCP servers with one-command install into MCP clients. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Toolhive](https://github.com/stacklok/toolhive) - Secure MCP server manager. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)

### Agent gateways and LLMOps

- [LiteLLM](https://github.com/BerriAI/litellm) - Unified OpenAI-compatible gateway and Python SDK fronting 100+ providers and local engines. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [OpenLLM](https://github.com/bentoml/OpenLLM) - BentoML project for serving open-source LLMs behind an OpenAI-compatible API. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Portkey AI Gateway](https://github.com/Portkey-AI/gateway) - High-performance edge gateway that routes to 200+ LLMs with guardrails and fallbacks. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [promptfoo](https://github.com/promptfoo/promptfoo) - CLI and library for evaluating and red-teaming LLM apps with side-by-side comparisons. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [TensorZero](https://github.com/tensorzero/tensorzero) - Rust-based LLMOps stack unifying gateway, observability, evals, and optimization. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Weave](https://github.com/wandb/weave) - W&B's developer toolkit for tracing, evaluating, and debugging GenAI applications. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)

### Tool and integration platforms

- [Composio](https://github.com/ComposioHQ/composio) - SDK providing 1000+ authenticated tool integrations and a sandboxed workbench for any agent framework. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)

### Document ingestion

- [Crawl4AI](https://github.com/unclecode/crawl4ai) - Open-source web crawler and scraper that emits LLM-ready Markdown for RAG. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Docling](https://github.com/docling-project/docling) - IBM-led document processor that converts PDFs, DOCX, PPTX, and images into structured layouts. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [MarkItDown](https://github.com/microsoft/markitdown) - Microsoft utility that converts arbitrary files to clean Markdown for LLM pipelines. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Scrapling](https://github.com/D4Vinci/Scrapling) - Adaptive Python web scraping framework with stealth, anti-bot bypass, and full-crawl support. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

### Agent memory and RAG

- [Cognee](https://github.com/topoteretes/cognee) - Knowledge engine giving agents persistent memory via combined vector and graph stores. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Graphiti](https://github.com/getzep/graphiti) - Temporal knowledge-graph framework for tracking how facts change over time with provenance. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Kotaemon](https://github.com/Cinnamon/kotaemon) - Open-source document-chat UI with advanced citation and multi-modal retrieval. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [LangChain](https://github.com/langchain-ai/langchain) - LLM application framework. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Letta](https://github.com/letta-ai/letta) - Stateful agents with long-term memory, formerly MemGPT. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [LlamaIndex](https://github.com/run-llama/llama_index) - Data framework for LLM applications. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Mem0](https://github.com/mem0ai/mem0) - Memory layer for AI agents. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Onyx](https://github.com/onyx-dot-app/onyx) - Self-hostable enterprise chat with agentic RAG, web search, and code execution over your data. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [PaperQA](https://github.com/Future-House/paper-qa) - High-accuracy agentic RAG for scientific PDFs with iterative search and in-text citations. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [RAGFlow](https://github.com/infiniflow/ragflow) - RAG engine with deep document parsing, intelligent chunking, and grounded citations. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Zep](https://www.getzep.com) - Long-term memory for AI agents. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Vector databases

- [Chroma](https://www.trychroma.com) - Open-source embedding database. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [LanceDB](https://lancedb.github.io/lancedb/) - Serverless vector database with native Metal support. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [pgvector](https://github.com/pgvector/pgvector) - Vector similarity search extension for Postgres. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Qdrant](https://qdrant.tech) - Vector search engine with Docker support on Apple Silicon. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Weaviate](https://weaviate.io) - Open-source vector database with hybrid search. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Browser and computer-use agents

- [Anthropic Computer Use](https://docs.claude.com/en/docs/build-with-claude/computer-use) - Claude API for controlling the desktop. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [browser-use](https://github.com/browser-use/browser-use) - Make websites accessible for AI agents. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Camoufox](https://github.com/daijro/camoufox) - Stealth Firefox fork for undetected automation. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [OmniParser](https://github.com/microsoft/OmniParser) - Screen parsing for GUI agents. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Playwright](https://playwright.dev) - Cross-browser automation library. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Skyvern](https://github.com/Skyvern-AI/skyvern) - Automate browser workflows with LLMs. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Stagehand](https://github.com/browserbase/stagehand) - AI web browsing framework. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)

### Voice and multimodal agents

- [Dia](https://github.com/nari-labs/dia) - 1.6B dialogue TTS with speaker control and emotion conditioning for multi-voice scenes. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Kokoro TTS](https://github.com/hexgrad/kokoro) - 82M-parameter open-weight TTS that hits top TTS-Arena quality while running fast on Apple Silicon. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Moshi](https://github.com/kyutai-labs/moshi) - Kyutai's real-time full-duplex speech-text foundation model. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [OpenVoice](https://github.com/myshell-ai/OpenVoice) - Instant voice cloning. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Parakeet](https://github.com/NVIDIA/NeMo) - NVIDIA ASR model, convertible to CoreML. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Piper](https://github.com/rhasspy/piper) - Fast neural text-to-speech. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [SenseVoice](https://github.com/FunAudioLLM/SenseVoice) - Multilingual speech understanding. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Sesame CSM](https://github.com/SesameAILabs/csm) - Conversational speech model that produces RVQ audio codes from text and audio with a Llama backbone. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Ultravox](https://github.com/fixie-ai/ultravox) - Real-time speech-to-speech LLM. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Whisper.cpp](https://github.com/ggerganov/whisper.cpp) - C/C++ port of Whisper with Metal acceleration. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [WhisperX](https://github.com/m-bain/whisperX) - Whisper with speaker diarization. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)

### Agent UIs

- [AnythingLLM](https://anythingllm.com) - Full-stack RAG application for any LLM. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Cherry Studio](https://github.com/CherryHQ/cherry-studio) - Cross-platform native desktop client with 300+ preconfigured assistants. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Enchanted](https://github.com/gluonfield/enchanted) - Native macOS UI for Ollama. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [LibreChat](https://www.librechat.ai) - Enhanced ChatGPT clone with multi-provider support. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Msty](https://msty.app) - Native chat UI for local and remote models. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [NextChat](https://github.com/ChatGPTNextWeb/NextChat) - Lightweight cross-platform chat client with plugin and MCP support. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Open WebUI](https://openwebui.com) - Extensible self-hosted AI interface. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [SillyTavern](https://github.com/SillyTavern/SillyTavern) - Locally installed unified frontend for many LLM APIs with deep customization. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Vane](https://github.com/ItzCrazyKns/Vane) - Privacy-focused self-hosted answering engine (ex-Perplexica) with web source citations. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Orchestration and eventing

- [Activepieces](https://www.activepieces.com) - Open-source Zapier alternative. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Dagu](https://github.com/dagu-org/dagu) - Single-binary DAG-based cron replacement with web UI and YAML workflows. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Huginn](https://github.com/huginn/huginn) - Build agents that perform automated tasks. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Kestra](https://github.com/kestra-io/kestra) - Event-driven orchestration platform for scheduled and triggered workflows with 600+ plugins. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [n8n](https://n8n.io) - Fair-code workflow automation with LLM nodes. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Temporal](https://temporal.io) - Durable execution workflow engine. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Trigger.dev](https://trigger.dev) - Open-source background job framework. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Windmill](https://www.windmill.dev) - Developer platform for internal tools and workflows. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Observability

- [Helicone](https://github.com/Helicone/helicone) - Self-hosted LLM observability. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Langfuse](https://langfuse.com) - Open-source LLM engineering platform. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [OpenLLMetry](https://github.com/traceloop/openllmetry) - OpenTelemetry for LLM apps. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Phoenix](https://phoenix.arize.com) - ML observability from Arize. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Image and video agents

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI) - Node-based Stable Diffusion UI with Metal support. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Draw Things](https://drawthings.ai) - Apple Silicon native Stable Diffusion app with CLI. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Fooocus](https://github.com/lllyasviel/Fooocus) - Simplified SDXL generation UI. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [InvokeAI](https://invoke-ai.github.io/InvokeAI/) - Professional Stable Diffusion platform. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)

### Agent bridges

- [claude-code-telegram](https://github.com/richardbaxter/claude-code-telegram) - Telegram bridge for Claude Code. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [matterbridge](https://github.com/42wim/matterbridge) - Bridge between chat protocols. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Hardware

Pick the right mini. Unified memory is not upgradeable, choose generously.

| Model | Year | Min RAM | Max RAM | Max storage | Notes |
|---|---|---|---|---|---|
| Mac mini M1 | 2020 | 8 GB | 16 GB | 2 TB | Great bargain, limited for 13B+ models |
| Mac mini M2 / M2 Pro | 2023 | 8 / 16 GB | 24 / 32 GB | 8 TB | Sweet spot for most home servers |
| Mac mini M4 / M4 Pro | 2024 | 16 / 24 GB | 32 / 64 GB | 8 TB | Best for agentic workloads and 70B models |

- [Macs Fan Control](https://crystalidea.com/macs-fan-control) - Monitor and override fan curves. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Network UPS Tools](https://networkupstools.org) - NUT client for safe shutdown with a UPS. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [OWC Thunderbolt docks](https://www.owc.com/solutions/thunderbolt) - Quality hubs for storage and display expansion. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Satechi stands](https://satechi.net) - Aluminum stands with USB-C passthrough. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)

See [docs/hardware.md](docs/hardware.md) for detailed picks and sizing.

---

## OS and base setup

- [Auto-Login Settings](https://support.apple.com/guide/mac-help/set-your-mac-to-log-in-automatically-mh27627/mac) - Required for headless post-reboot startup. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [BetterDisplay](https://github.com/waydabber/BetterDisplay) - Virtual display for headless Apple Silicon Macs. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [caffeinate(8)](https://ss64.com/osx/caffeinate.html) - Prevent sleep for a process or timeframe. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [defaults(1)](https://ss64.com/osx/defaults.html) - Scriptable access to macOS preferences. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Headless Mac](https://github.com/dickreuter/headless_mac) - Curated settings for running Mac without a display. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [sharing(1)](https://ss64.com/osx/sharing.html) - Configure SMB, AFP, and Time Machine shares from CLI. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Remote access

- [Blink Shell](https://blink.sh) - Best-in-class SSH/mosh client for iOS and iPadOS. ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/) - Expose local services without opening ports via `cloudflared`. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [mosh](https://mosh.org) - Mobile shell, survives roaming and sleep. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Tailscale](https://tailscale.com) - WireGuard-based mesh VPN with SSH, Funnel, and Serve. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [WireGuard](https://www.wireguard.com) - Fast modern VPN, use `wg-quick` via launchd. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [wush](https://github.com/coder/wush) - Ad-hoc P2P SSH and rsync over WireGuard using Tailscale DERP without a tailnet. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Containers and virtualization

- [Apple Container](https://github.com/apple/container) - Apple's Swift-native Linux container runtime using lightweight VMs, optimized for Apple Silicon. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Cilicon](https://github.com/traderepublic/Cilicon) - Self-hosted ephemeral macOS CI runner that clones APFS VM bundles for GitHub Actions and Buildkite. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Colima](https://github.com/abiosoft/colima) - Container runtimes on Lima, fast Docker replacement. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [CapRover](https://caprover.com) - One-click self-hosted PaaS on Docker Swarm with Nginx and Let's Encrypt. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Coolify](https://coolify.io) - Self-hostable Heroku/Vercel alternative deploying apps and 280+ services over SSH. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) - Mainstream Docker on macOS with GUI. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Dockge](https://github.com/louislam/dockge) - Reactive web UI dedicated to managing Docker Compose stacks. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Lima](https://github.com/lima-vm/lima) - Linux VMs with automatic file sharing and port forwarding. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [OrbStack](https://orbstack.dev) - Fast, light Docker and Linux VMs for macOS. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Parallels Desktop](https://www.parallels.com/products/desktop/) - Full commercial VM suite with server mode. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Portainer CE](https://www.portainer.io) - Web UI for managing Docker, Compose, Swarm, and Kubernetes containers. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Rancher Desktop](https://rancherdesktop.io) - Kubernetes and container management on the desktop. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Tart](https://github.com/cirruslabs/tart) - Native Apple Silicon VMs for macOS and Linux guests. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [UTM](https://mac.getutm.app) - QEMU-based VMs with a native UI. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Arcane](https://github.com/ofkm/arcane) - Modern Go/Svelte Docker management UI covering images, volumes, networks, and Compose stacks. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Runtipi](https://github.com/runtipi/runtipi) - Personal home-server orchestrator with a one-click app store built on Docker Compose. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Media servers

- [Audiobookshelf](https://audiobookshelf.org) - Self-hosted audiobook and podcast server with mobile apps. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Channels DVR](https://getchannels.com) - DVR server for live TV. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Emby](https://emby.media) - Media server fork of MediaBrowser. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Ente](https://github.com/ente-io/ente) - End-to-end-encrypted self-hostable photos, auth, and locker. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white)
- [Jellyfin](https://jellyfin.org) - Free and open source media server. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Jellyseerr](https://seerr.dev) - Unified request and discovery manager for Jellyfin, Plex, and Emby. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Komga](https://www.komga.org) - Self-hosted media server for comics, manga, and eBooks. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Navidrome](https://navidrome.org) - Lightweight Subsonic/OpenSubsonic-compatible self-hosted music streaming. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Plex Media Server](https://www.plex.tv) - The original streaming-first media server. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [RomM](https://romm.app) - Self-hosted ROM manager with EmulatorJS and 400+ platforms. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Tautulli](https://www.tautulli.com) - Python monitoring and analytics companion for Plex. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Storage and NAS

- [Mountain Duck](https://mountainduck.io) - Mount S3/SFTP/WebDAV volumes in Finder. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [OpenZFS on OS X](https://openzfsonosx.org) - ZFS filesystem for external storage pools. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Resilio Sync](https://www.resilio.com/individuals/) - P2P file sync without a cloud. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [rclone](https://rclone.org) - Rsync for cloud storage, 70+ backends. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Syncthing](https://syncthing.net) - Continuous file sync across devices. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Self-hosted apps

### Productivity and notes

- [Actual Budget](https://actualbudget.org) - Envelope-budgeting personal finance app. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [AFFiNE](https://github.com/toeverything/AFFiNE) - Local-first open-source Notion/Miro alternative unifying docs, whiteboards, and databases. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white)
- [AppFlowy](https://appflowy.com) - Open-source local-first Notion alternative with docs, wikis, tasks, and AI. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white)
- [BookStack](https://www.bookstackapp.com) - Self-hosted wiki organized into Books, Chapters, and Pages with WYSIWYG editing. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Docmost](https://docmost.com) - Confluence/Notion alternative with MCP support and diagramming. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Firefly III](https://firefly-iii.org) - Self-hosted double-entry personal finance manager with budgets, rules, and API. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [HedgeDoc](https://hedgedoc.org) - Real-time collaborative markdown editor, formerly CodiMD. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Logseq](https://logseq.com) - Privacy-first local-first outliner and knowledge graph for daily notes and backlinks. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white)
- [Memos](https://usememos.com) - Self-hosted timeline for quick markdown notes, daily logs, and snippets. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Mealie](https://mealie.io) - Recipe manager and meal planner with URL scraping and shopping lists. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [NocoDB](https://nocodb.com) - No-code Airtable alternative turning Postgres/MySQL into a spreadsheet UI. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Outline](https://www.getoutline.com) - Team knowledge base with real-time collaboration and AI search. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [SilverBullet](https://silverbullet.md) - Programmable browser-based markdown PKM platform with Lua scripting. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Trilium Next](https://github.com/TriliumNext/Notes) - Hierarchical self-hosted knowledge base with scripting, relations, and local-first sync. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Vikunja](https://vikunja.io) - Open-source task manager with list, kanban, Gantt, and table views. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Huly](https://github.com/hcengineering/platform) - All-in-one Linear, Jira, Slack, and Notion alternative with native arm64 containers. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Khoj](https://github.com/khoj-ai/khoj) - Self-hostable personal AI that answers across your notes, docs, and the web. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [ToolJet](https://github.com/ToolJet/ToolJet) - Open-source low-code builder for internal tools and dashboards with 80+ data sources. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Files and documents

- [CryptPad](https://cryptpad.org) - End-to-end-encrypted collaborative office suite (docs, sheets, slides, kanban). ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Etherpad](https://etherpad.org) - Real-time collaborative plain-text editor with 290+ plugins. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Filebrowser](https://github.com/filebrowser/filebrowser) - Single-binary web file manager for uploading, editing, and sharing files. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Gitea](https://gitea.io) - Lightweight self-hosted git service. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Forgejo](https://forgejo.org) - Community Gitea fork for self-hosted git. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Immich](https://immich.app) - Google Photos replacement with ML. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Nextcloud](https://nextcloud.com) - Full self-hosted cloud suite. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Paperless-ngx](https://docs.paperless-ngx.com) - Document management with OCR. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Stirling PDF](https://www.stirlingpdf.com) - 60+ PDF tools for merging, signing, converting, and OCR. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Vaultwarden](https://github.com/dani-garcia/vaultwarden) - Lightweight Bitwarden server in Rust. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Zoekt](https://github.com/sourcegraph/zoekt) - Trigram-indexed source code search with symbol-aware ranking. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Gitleaks](https://github.com/gitleaks/gitleaks) - Single-binary secret scanner for git history and working trees. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

### Reading and feeds

- [ArchiveBox](https://archivebox.io) - Self-hosted web archive preserving pages as HTML, PDF, PNG, and WARC. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [FreshRSS](https://freshrss.org) - Scalable self-hosted RSS/Atom aggregator with WebSub and mobile sync. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Karakeep](https://karakeep.app) - AI-powered bookmark and read-it-later app. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Miniflux](https://miniflux.app) - Minimalist RSS reader. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Shiori](https://github.com/go-shiori/shiori) - Single-binary Go bookmark manager with content archival and Pocket import. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Readeck](https://codeberg.org/readeck/readeck) - Single-binary Go read-it-later and bookmark manager with article extraction and full-text search. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Wallabag](https://wallabag.org) - Self-hosted read-it-later app for saving, syncing, and reading web articles. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Analytics and monitoring

- [changedetection.io](https://changedetection.io) - Website change monitor with CSS/xPath filters and 85+ notification channels. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Plausible CE](https://plausible.io) - Cookieless, privacy-friendly web analytics. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [PostHog](https://posthog.com) - Product analytics, session replay, feature flags, and experiments platform. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Rybbit](https://rybbit.com) - Modern cookieless analytics with session replay, funnels, and web vitals. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Medama](https://github.com/medama-io/medama) - Sub-1 KB cookieless analytics tracker delivered as a single Go binary. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Umami](https://umami.is) - Simple, privacy-focused self-hosted web analytics. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Vince](https://github.com/vinceanalytics/vince) - Plausible-style privacy analytics as one dependency-free Go binary with automatic TLS. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Mail, comms, and push

- [Conduit](https://conduit.rs) - Simple single-binary Rust Matrix homeserver with embedded RocksDB. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [docker-mailserver](https://github.com/docker-mailserver/docker-mailserver) - Production-ready containerized full mail stack. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Gotify](https://gotify.net) - Self-hosted push-notification server with REST API and Android client. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [ntfy](https://ntfy.sh) - HTTP-based pub/sub push notification service, free public and self-hostable. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Stalwart](https://stalw.art) - All-in-one Rust mail and collaboration server with SMTP, IMAP, JMAP, and CalDAV. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Listmonk](https://github.com/knadh/listmonk) - Single-binary self-hosted newsletter and mailing-list manager backed by Postgres. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Synapse](https://github.com/element-hq/synapse) - Reference Python implementation of the Matrix homeserver. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Network tunnels and zero-trust

- [Headscale](https://github.com/juanfont/headscale) - Self-hosted open-source implementation of the Tailscale coordination server. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [NetBird](https://netbird.io) - WireGuard-based zero-trust mesh VPN with SSO and policies. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Pangolin](https://github.com/fosrl/pangolin) - WireGuard-based identity-aware reverse proxy and remote-access platform with RBAC. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [zrok](https://zrok.io) - OpenZiti-based peer-to-peer sharing and secure tunneling alternative to ngrok. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

### Privacy front-ends and search

- [Invidious](https://invidious.io) - Privacy-respecting alternative front-end for YouTube with RSS and API. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [SearXNG](https://docs.searxng.org) - Privacy-respecting metasearch engine aggregating up to 251 sources. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Smart home

- [ESPHome](https://esphome.io) - DIY firmware for ESP-based smart devices. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [HOOBS](https://hoobs.org) - Homebridge distribution with a web UI. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Home Assistant](https://www.home-assistant.io) - Leading open-source home automation platform. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Homebridge](https://homebridge.io) - Bridge non-HomeKit accessories into Apple Home. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Frigate](https://frigate.video) - Local AI-driven NVR with real-time object detection and Home Assistant integration. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Matterbridge](https://github.com/Luligu/matterbridge) - Node-based Matter plugin manager that bridges devices into Apple Home, Google, and Alexa. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Node-RED](https://nodered.org) - Flow-based programming for automation. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [python-matter-server](https://github.com/home-assistant-libs/python-matter-server) - Reference Matter controller WebSocket server used by Home Assistant. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [RuView](https://github.com/ruvnet/RuView) - WiFi DensePose: camera-free human pose, presence, and vital-sign monitoring over commodity WiFi. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Scrypted](https://scrypted.app) - HomeKit Secure Video bridge for existing cameras. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Viseron](https://github.com/roflcoopter/viseron) - Self-hosted local-only NVR with object detection, motion detection, and face recognition. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Z-Wave JS UI](https://github.com/zwave-js/zwave-js-ui) - Z-Wave controller UI. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Ad blocking and DNS

- [AdGuard Home](https://adguard.com/en/adguard-home/overview.html) - Network-wide ad and tracker blocker. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html) - Lightweight DNS, DHCP, TFTP. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [NextDNS](https://nextdns.io) - Cloud DNS with filtering and analytics. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Pi-hole](https://pi-hole.net) - DNS sinkhole, Docker on macOS. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Unbound](https://nlnetlabs.nl/projects/unbound/about/) - Validating, recursive DNS resolver. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Reverse proxy and TLS

- [Caddy](https://caddyserver.com) - Web server with automatic HTTPS. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [cloudflared](https://github.com/cloudflare/cloudflared) - Cloudflare Tunnel client, no open ports required. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [nginx](https://nginx.org) - Mature high-performance reverse proxy. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Tailscale Serve](https://tailscale.com/kb/1242/tailscale-serve) - Publish services on the tailnet with TLS. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Reproxy](https://github.com/umputun/reproxy) - Single-binary edge proxy with Docker discovery, Let's Encrypt, and Prometheus metrics. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Traefik](https://traefik.io) - Cloud-native reverse proxy with auto-discovery. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Monitoring and observability

- [Beszel](https://github.com/henrygd/beszel) - Lightweight hub-and-agent server monitoring with native arm64 macOS agent. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Dozzle](https://github.com/amir20/dozzle) - Real-time web log viewer for Docker, Colima, and OrbStack. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Gatus](https://gatus.io) - Developer-focused self-hosted health-check and status page driven by YAML. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Glances](https://nicolargo.github.io/glances/) - Cross-platform system monitor with a web UI. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Grafana](https://grafana.com/oss/grafana/) - Dashboards for any time-series backend. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Netdata](https://www.netdata.cloud) - Real-time performance monitoring. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [NeoHtop](https://github.com/Abdenasser/neohtop) - Notarized Rust + Tauri process viewer that replaces Activity Monitor. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [node_exporter](https://github.com/prometheus/node_exporter) - Prometheus exporter for host metrics. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Prometheus](https://prometheus.io) - Time-series database and monitoring system. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Healthchecks](https://github.com/healthchecks/healthchecks) - Dead-man's-switch monitoring for cron and launchd jobs with 25+ notifiers. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [rustnet](https://github.com/domcyrus/rustnet) - Rust TUI network monitor with DPI and per-process attribution. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [SigNoz](https://github.com/SigNoz/signoz) - OpenTelemetry-native unified logs, metrics, and traces backend. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Uptime Kuma](https://github.com/louislam/uptime-kuma) - Self-hosted uptime monitoring. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Automation and scheduling

- [cron](https://ss64.com/osx/crontab.html) - Classic scheduler, still fine for simple jobs. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Keyboard Maestro](https://www.keyboardmaestro.com) - Powerful macro automation. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [LaunchControl](https://www.soma-zone.com/LaunchControl/) - Polished GUI for launchd job management. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [launchd](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html) - macOS native service manager, use instead of cron. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [shortcuts(1)](https://support.apple.com/guide/shortcuts-mac/intro-to-the-shortcuts-command-line-tool-apd455c82f02/mac) - Invoke Apple Shortcuts from CLI to chain agents. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Development environments

- [code-server](https://github.com/coder/code-server) - VS Code in the browser. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Devbox](https://www.jetify.com/devbox/) - Isolated shells from Nix packages. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Homebrew](https://brew.sh) - The missing package manager for macOS. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [JetBrains Gateway](https://www.jetbrains.com/remote-development/gateway/) - Remote JetBrains IDEs. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [nix-darwin](https://github.com/LnL7/nix-darwin) - Declarative macOS configuration with Nix. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Backup

- [Arq](https://www.arqbackup.com) - Backup to any cloud with client-side encryption. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Borg](https://www.borgbackup.org) - Deduplicating encrypted backup. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Kopia](https://kopia.io) - Fast encrypted snapshot backup. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [restic](https://restic.net) - Fast, secure, efficient backup program. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [shallow-backup](https://github.com/alichtman/shallow-backup) - Snapshot dotfiles, Brewfile, pip/npm/cargo lists, and VS Code extensions to a git repo. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Time Machine](https://support.apple.com/guide/mac-help/back-up-your-mac-with-time-machine-mh11421/mac) - Native macOS backup, can serve as a network target. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Security

- [Authentik](https://goauthentik.io) - Self-hosted identity provider supporting OAuth2/OIDC, SAML, LDAP, and passkeys. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Bitwarden Self-Host](https://bitwarden.com/help/install-on-premise-manual/) - Official Bitwarden server for password, passkey, and Secrets Manager. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [ClamAV](https://www.clamav.net) - Open-source antivirus engine. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [CrowdSec](https://www.crowdsec.net) - Open-source collaborative IPS with crowdsourced blocklists and bouncers. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [FileVault](https://support.apple.com/guide/mac-help/protect-data-on-your-mac-with-filevault-mh11785/mac) - Full-disk encryption built into macOS. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Infisical](https://infisical.com) - Open-source secrets, certificates, and PAM platform with CLI, SDKs, and K8s operator. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [KnockKnock](https://objective-see.org/products/knockknock.html) - Enumerates every launchd and persistence vector, invaluable before opening a mini to the internet. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Little Snitch](https://obdev.at/products/littlesnitch/index.html) - Host-based application firewall. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [LuLu](https://objective-see.org/products/lulu.html) - Free macOS firewall by Objective-See. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [osquery](https://osquery.io) - SQL-powered operating system instrumentation. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Pareto Security](https://github.com/ParetoSecurity/pareto-mac) - Automated baseline audit covering FileVault, firewall, Gatekeeper, SSH, and updates. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Pocket ID](https://github.com/pocket-id/pocket-id) - Minimalist OIDC provider built around passkey-only authentication. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [age](https://github.com/FiloSottile/age) - Modern composable file-encryption CLI with YubiKey plugins and SSH-key support. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Santa](https://github.com/google/santa) - Binary authorization framework by Google. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [SOPS](https://github.com/getsops/sops) - Mozilla secrets-in-git tool that encrypts YAML/JSON/ENV leaves with age, PGP, or cloud KMS. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [TinyAuth](https://github.com/steveiliop56/tinyauth) - Lightweight forward-auth middleware that adds SSO in front of Traefik, Caddy, or nginx. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Audio and AirPlay

- [Music Assistant](https://music-assistant.io) - Music library manager with multi-provider streaming. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Roon Core](https://roon.app) - High-fidelity music management server. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [shairport-sync](https://github.com/mikebrady/shairport-sync) - AirPlay audio receiver. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)

---

## Game streaming

- [Moonlight](https://moonlight-stream.org) - Client for NVIDIA GameStream and Sunshine hosts. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Parsec](https://parsec.app) - Low-latency remote desktop for gaming. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Steam Link](https://store.steampowered.com/app/353380/Steam_Link/) - Stream Steam games across the LAN. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Sunshine](https://github.com/LizardByte/Sunshine) - Self-hosted GameStream host. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Torrents and Usenet

- [Bazarr](https://www.bazarr.media) - Companion to Sonarr/Radarr for subtitles. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [NZBGet](https://nzbget.com) - Efficient Usenet downloader in C++. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Prowlarr](https://prowlarr.com) - Indexer manager for the *arr suite. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [qBittorrent](https://www.qbittorrent.org) - Free and open-source BitTorrent client. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Radarr](https://radarr.video) - Movie collection manager. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [SABnzbd](https://sabnzbd.org) - Python-based Usenet downloader. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Sonarr](https://sonarr.tv) - TV series collection manager. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Transmission](https://transmissionbt.com) - Minimal BitTorrent client. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Photo and video

- [Final Cut Pro render node](https://support.apple.com/guide/final-cut-pro/share-projects-to-compressor-ver6b5b30efb/mac) - Use the mini as a Compressor rendering host. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [LibrePhotos](https://github.com/LibrePhotosApp/LibrePhotos) - Open-source photo management with ML. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [PhotoPrism](https://www.photoprism.app) - AI-powered photos app for browsers, mobile, and TVs. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Databases

- [DuckDB](https://duckdb.org) - In-process analytical OLAP database. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [MariaDB](https://mariadb.org) - Open-source MySQL fork. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Postgres.app](https://postgresapp.com) - Postgres as a macOS app, no config required. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Redis](https://redis.io) - In-memory data store. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Dashboards

- [Dashy](https://dashy.to) - Feature-rich homepage for your server. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Heimdall](https://heimdall.site) - Application dashboard for all your apps. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Homarr](https://homarr.dev) - Sleek dashboard with real-time widgets. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Homepage](https://gethomepage.dev) - Modern, fast, highly customizable dashboard. ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Homer](https://github.com/bastienwirtz/homer) - Dead-simple static YAML-driven homepage dashboard. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## Power and thermals

- [asitop](https://github.com/tlkh/asitop) - Python nvtop-style CLI surfacing E/P-cluster, GPU, and ANE power via `powermetrics`. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [macmon](https://github.com/vladkens/macmon) - Sudoless Rust TUI and Prometheus metrics server for M-series power, temperature, and bandwidth. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [mactop](https://github.com/context-labs/mactop) - Go-based terminal dashboard for Apple Silicon CPU, GPU, RAM, and power with sparklines. ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-000000?style=flat-square&logo=apple&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [pmset(1)](https://ss64.com/osx/pmset.html) - macOS power management configuration. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [powermetrics(1)](https://ss64.com/osx/powermetrics.html) - Live CPU/GPU/ANE power telemetry. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [SMC Fan Control](https://github.com/hholtmann/smcFanControl) - Override fan speeds on Intel Macs. ![Intel](https://img.shields.io/badge/Intel-0071C5?style=flat-square&logo=intel&logoColor=white) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Stats](https://github.com/exelban/stats) - Open-source macOS menu bar monitor for CPU, GPU, memory, network, disks, sensors, and fan RPM. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [TG Pro](https://www.tunabellysoftware.com/tgpro/) - Temperature monitoring and fan control. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)

See [docs/power-management.md](docs/power-management.md) for `pmset` tuning and UPS setup.

---

## Bootstrap and dotfiles

- [dotbot](https://github.com/anishathalye/dotbot) - Bootstrap a dotfiles setup with YAML. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) - Install from a `Brewfile` manifest. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [mac-dev-setup](https://github.com/sb2nov/mac-dev-setup) - Classic dev bootstrap guide. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)
- [mas](https://github.com/mas-cli/mas) - Mac App Store CLI that lets a Brewfile install App Store apps headlessly. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [strap](https://github.com/MikeMcQuaid/strap) - Bootstrap a new macOS machine. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square)

---

## CI/CD and build farms

Mac mini is a first-class iOS/macOS CI runner. These tools let a single mini (or a cluster) host build agents for GitHub Actions, Buildkite, Jenkins, and GitLab.

- [Buildkite Agent](https://buildkite.com/docs/agent/v3/macos) - Apple-Silicon-native CI agent with `launchd` spawn support for multi-runner minis. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [fastlane](https://github.com/fastlane/fastlane) - iOS and Android release automation toolchain that pairs with any macOS CI runner. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [GitHub Actions Runner](https://github.com/actions/runner) - Official self-hosted runner shipping arm64 macOS binaries. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Xcodes.app](https://github.com/XcodesOrg/XcodesApp) - GUI companion that manages multiple Xcodes and platform runtimes. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [xcodes](https://github.com/XcodesOrg/xcodes) - CLI that installs and switches between Xcode versions, essential for pinned CI images. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Networking

- [iperf3](https://iperf.fr/) - Canonical TCP/UDP throughput tester, arm64 via Homebrew. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [mDNS-discovery](https://github.com/lukszar/mDNS-discovery) - Bash script that enumerates every Bonjour service on the LAN. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [mDNSResponder](https://github.com/apple-oss-distributions/mDNSResponder) - Apple's open-source Bonjour daemon and `dns-sd` CLI. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [MinIO Community](https://min.io) - S3-compatible open-source object storage server. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white) ![Paid](https://img.shields.io/badge/Paid-DAA520?style=flat-square)
- [Wireshark](https://www.wireshark.org) - Apple-Silicon-native packet capture and analysis. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Sleep, wake, and persistence

- [Amphetamine](https://apps.apple.com/us/app/amphetamine/id937984704) - Mac App Store utility with rich triggers that complements `caffeinate`. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [SleepWatcher](https://www.bernhard-baehr.de/) - Long-lived daemon that runs scripts on sleep, wake, display dim, and idle timeouts. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [wake-my-nas](https://github.com/dgeske/wake-my-nas) - macOS LaunchAgent that wakes a NAS by magic packet whenever the mini wakes. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## CLI power tools

Tools that make SSH-first Mac mini administration bearable.

- [duf](https://github.com/muesli/duf) - Modern colorized `df` replacement with JSON output. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [git-cliff](https://github.com/orhun/git-cliff) - Rust changelog generator for Conventional Commits. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [glow](https://github.com/charmbracelet/glow) - Terminal markdown reader for browsing runbooks over SSH. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [HTTPie](https://github.com/httpie/cli) - Human-friendly HTTP client for debugging self-hosted APIs. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [lnav](https://lnav.org) - Terminal log navigator with SQL querying over rotated logs. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [m-cli](https://github.com/rgcr/m-cli) - Swiss-army CLI wrapping 40+ macOS admin tasks. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Miller](https://github.com/johnkerl/miller) - awk/sed/cut for CSV, TSV, and JSON as a single Go binary. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [Nushell](https://www.nushell.sh) - Structured-data modern shell for scripting server pipelines. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [yq](https://github.com/mikefarah/yq) - jq-compatible processor for YAML, JSON, TOML, XML. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Rust `cd` that learns frequent directories. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## File transfer

- [croc](https://github.com/schollz/croc) - PAKE-encrypted CLI file-transfer with resumable transfers. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
- [Magic Wormhole](https://github.com/magic-wormhole/magic-wormhole) - Python CLI that transfers files between machines using short phonetic codes. ![Universal](https://img.shields.io/badge/Universal-636363?style=flat-square) ![Native](https://img.shields.io/badge/Native-111111?style=flat-square&logo=apple&logoColor=white)

---

## Reference lists

- [awesome-homelab](https://github.com/awesome-foss/awesome-sysadmin) - Sysadmin tooling inspiration.
- [awesome-macOS](https://github.com/iCHAIT/awesome-macOS) - Apps and tools for macOS in general.
- [awesome-macos-command-line](https://github.com/herrbischoff/awesome-macos-command-line) - Shell tricks and CLI one-liners for macOS power users.
- [awesome-macos-server](https://github.com/enzo-zsh/awesome-macos-server) - Related curated list focused on turning any Mac into a server.
- [awesome-selfhosted](https://github.com/awesome-selfhosted/awesome-selfhosted) - Broad self-hosted software list.
- [geerlingguy/mini-rack](https://github.com/geerlingguy/mini-rack) - Jeff Geerling's open-source 10-inch rack designs sized for Mac mini clusters.
- [open-source-mac-os-apps](https://github.com/serhii-londar/open-source-mac-os-apps) - Large catalogue of open-source macOS apps.

---

## Contributing

Contributions are very welcome. Read the [contribution guidelines](CONTRIBUTING.md) first. Every entry must pass `awesome-lint` and have a one-sentence description ending with a period.

## License

[![CC0](https://licensebuttons.net/p/zero/1.0/88x31.png)](http://creativecommons.org/publicdomain/zero/1.0/)

To the extent possible under law, the maintainers have waived all copyright and related rights to this work.
