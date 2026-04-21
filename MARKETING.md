# Marketing & Submission Playbook

Not tracked by awesome-lint. Internal checklist for promoting the repo.

Repo: https://github.com/momenbasel/awesome-mac-mini-homeserver
Site: https://momenbasel.github.io/awesome-mac-mini-homeserver/

---

## 1. Awesome-list submissions

Open a PR to each with a single new-line entry under the relevant section. Follow each list's `CONTRIBUTING.md` exactly.

### sindresorhus/awesome
- URL: https://github.com/sindresorhus/awesome
- Rules: 30-day repo age minimum, awesome-lint must pass, continuous commits
- Entry suggestion (under "Platforms > macOS" or "Miscellaneous"):
  ```
  - [Mac mini Home Server](https://github.com/momenbasel/awesome-mac-mini-homeserver#readme) - Running a Mac mini as a 24/7 home server with agentic AI.
  ```
- Wait until April 21 + 30 days = around 2026-05-21 before opening the PR.

### awesome-selfhosted/awesome-selfhosted
- URL: https://github.com/awesome-selfhosted/awesome-selfhosted
- Entry (under "Similar Lists" or "Related Projects"):
  ```
  - [Awesome Mac mini Home Server](https://github.com/momenbasel/awesome-mac-mini-homeserver) - Self-hosted tools curated specifically for Apple Silicon Mac mini 24/7 servers with agentic AI focus.
  ```

### iCHAIT/awesome-macOS
- URL: https://github.com/iCHAIT/awesome-macOS
- Entry (under "Related Awesome Lists"):
  ```
  - [awesome-mac-mini-homeserver](https://github.com/momenbasel/awesome-mac-mini-homeserver) - Tools for running a Mac mini as an agentic AI home server.
  ```

### awesome-foss/awesome-sysadmin
- URL: https://github.com/awesome-foss/awesome-sysadmin
- Fit under "Similar Projects" section.

### awesome-home-assistant
- URL: https://github.com/frenck/awesome-home-assistant
- Fit under "Related Awesome Lists" (we heavily reference HA, Scrypted, Matter).

### lauris/awesome-scala / punkpeye/awesome-mcp-servers / etc.
- Not a fit - skip unless targeting adjacent audiences.

---

## 2. Hacker News

**Title** (keep under 80 chars, no emoji, no clickbait):
```
Show HN: Awesome Mac mini Home Server - 260 curated agentic AI tools
```

**First comment** (post right after submission so it's pinned):
```
I kept buying Mac minis as "just dev boxes" and realizing they make absurdly
good 24/7 home servers - the M4 pulls 4-7W idle, has 64GB of GPU-addressable
unified memory, and macOS ships with SMB + Bonjour + launchd + Time Machine
server built in.

This list is what I wish existed when I started: 260 curated tools across 32
categories, a one-command installer with three stacks (agentic AI / media /
self-hosted), a Time Machine server script that turns an external drive into
a LAN-wide backup destination, and a RAM-sizing table for which local LLM fits
which mini.

Heaviest focus is on agentic AI because that's where Mac mini is genuinely
best-in-class: Ollama, MLX, Claude Code running as a scheduled launchd worker,
MCP servers, Apple Silicon-optimized WhisperKit/DiffusionKit, etc.

CC0 licensed. Would love PRs if I missed something.
```

Best posting times: **Tuesday-Thursday, 8-10am PST**. Avoid weekends.

---

## 3. Reddit

### r/selfhosted  (~450k subscribers)
- Title: `I built a curated list for running Mac mini as a 24/7 home server - 260 tools, one-command installers`
- Body:
  ```
  Hey r/selfhosted, after running a Mac mini as my always-on home server for
  about a year, I pulled together everything I use into a curated awesome-list.

  Link: https://github.com/momenbasel/awesome-mac-mini-homeserver

  - 260 tools curated, ~32 categories
  - Agentic AI (Ollama, Claude Code, MLX) is the headline section because Mac
    mini is genuinely best in class here - 4-7W idle, 64GB unified memory,
    Metal + ANE all usable
  - Three one-command install stacks: ./install.sh agentic / media / selfhosted
  - A Time Machine server script that turns an external drive into a LAN-wide
    backup destination for every other Mac in the house
  - CC0 licensed, awesome-lint CI, PRs welcome

  Not trying to sell anything. Just scratched my own itch.
  ```

### r/macmini  (~35k subscribers)
- Title: `Curated list: 260 tools for turning your Mac mini into a 24/7 home server`
- Focus on the hardware angle: "if you're wondering what to do with your old M1 mini..."

### r/homelab  (~1M subscribers)
- Title: `Mac mini as a homelab node - 260-tool curated list (agentic AI, self-hosted, media)`
- Be defensive - r/homelab skews Linux/x86. Lead with power-per-watt numbers.

### r/LocalLLaMA  (~600k subscribers)
- Title: `Mac mini as a 24/7 local LLM host - curated toolset with MLX, Ollama, exo clustering`
- This is the highest-signal audience. Focus the post on the Agentic AI subsection.

### r/MacOS
- Title: `Awesome Mac mini Home Server - a curated list of tools for headless 24/7 use`
- Under "Apps & Software" flair.

---

## 4. Twitter / X

### Launch tweet (pin for a week)
```
I built a curated list for turning a Mac mini into a 24/7 agentic AI home server.

260 tools across 32 categories.
Three one-command installers.
Time Machine server script.
CC0 licensed.

https://github.com/momenbasel/awesome-mac-mini-homeserver
```

### Thread (post as follow-ups)
1. "Why Mac mini? M4 pulls 4-7W idle, 64GB unified memory runs 70B Q4 models, silent fans, launchd + Bonjour + SMB + HomeKit + Time Machine built in. Nothing else hits this combo."
2. "Headline section is agentic AI. Ollama, MLX, Claude Code as a scheduled launchd worker, WhisperKit (CoreML), DiffusionKit, exo for clustering multiple Macs, every MCP server I could verify."
3. "One-command installs. `./install.sh agentic` spins up Ollama + Open WebUI + Langfuse + Claude Code + Aider. `./install.sh media` brings up Jellyfin + the full *arr stack. `./install.sh selfhosted` puts Vaultwarden + Paperless-ngx + Gitea + Homepage in Docker."
4. "The Time Machine script turns any external drive into a LAN-wide backup destination every Mac in the house can use. One `sudo ./scripts/time-machine-server.sh /Volumes/Drive` and you are done."
5. "PRs very welcome. CC0 so use anything. Stars help. Tools that need more coverage: smart home matter bridges, hardware CI farms, and anything MLX-native."

Tag: @sindresorhus @SimonW @awesome_re #MacMini #SelfHosted #LocalLLM #HomeLab

---

## 5. Product Hunt

- Category: `Developer Tools` or `Open Source`
- Tagline (60 char max): `260 curated tools to turn a Mac mini into an AI home server`
- Description:
  ```
  The Apple Silicon Mac mini is the best silent, low-power, AI-capable home
  server you can buy. This curated list has 260 tools across 32 categories
  plus three one-command installers to get you from zero to working in
  twenty minutes.
  ```
- Thumbnail: `assets/logo.png`
- Gallery: screenshots of install.sh TUI + README banner + GitHub Pages site

---

## 6. Dev.to / Medium article (optional deep dive)

Title: `How I turned a Mac mini into a 24/7 AI home server (and the 260 tools that made it work)`

Sections:
1. Why Mac mini beats every alternative for this use case
2. The agentic AI stack (Ollama, Claude Code, launchd)
3. The self-hosted apps I actually use day-to-day
4. The Time Machine server that backs up the whole household
5. What I got wrong the first three times
6. The full list

Cross-post to:
- dev.to (canonical = Medium)
- Medium
- Personal blog
- HashNode

---

## 7. Newsletters & aggregators

- **Hacker News newsletter** (self-submit via HN directly, no separate form)
- **TLDR Newsletter** - tip@tldrnewsletter.com
- **Console.dev** (dev tool newsletter) - they pick OSS discoveries - hello@console.dev
- **Bytes.dev** - similar audience
- **Sidebar.io** - design/dev links - submit via form

---

## 8. YouTube outreach (no pitching, just tag)

Creators who already cover Mac mini as a server - drop a polite reply if they post something where the list is relevant:

- Jeff Geerling (`@geerlingguy`)
- ServeTheHome (`@ServeTheHomeVideo`)
- Techno Tim (`@TechnoTim`)
- Alex the IT Pro
- Network Chuck
- DB Tech (self-hosted focus)

Do not spam. One reply per video at most.

---

## 9. SEO sanity checklist (already done)

- [x] Title tag with primary keyword + differentiator
- [x] Meta description 160-chars covering tools count + use case
- [x] Meta keywords (mac mini, home server, apple silicon, agentic AI, ollama, etc.)
- [x] Open Graph tags with 2000x666 banner
- [x] Twitter Card tags
- [x] JSON-LD schema: WebSite, SoftwareSourceCode, ItemList, BreadcrumbList
- [x] Canonical URL
- [x] robots.txt allowing all + pointing to sitemap
- [x] sitemap.xml with image entries
- [x] theme-color + color-scheme meta
- [x] GitHub repo topics (20) for github.com search discoverability
- [x] Descriptive alt text on banner
- [x] Semantic HTML (header, nav, section, footer)

---

## 10. Tracking

Check these weekly for the first 4 weeks:

- GitHub stars: https://star-history.com/#momenbasel/awesome-mac-mini-homeserver
- GitHub traffic: Insights -> Traffic (referrers show which platforms sent traffic)
- Google Search Console: verify the property at https://momenbasel.github.io/awesome-mac-mini-homeserver/ and submit sitemap
- Google Analytics / Plausible (optional) on the Pages site

---

## Cadence

- Week 1: HN + r/selfhosted + r/LocalLLaMA + Twitter launch
- Week 2: r/macmini + r/homelab + r/MacOS + Product Hunt
- Week 3: awesome-list PRs (after 30-day maturity)
- Week 4: Dev.to / Medium deep-dive article
- Ongoing: respond to every PR within 48h, merge good entries, thank contributors
