# RAM sizing for local LLMs on Mac mini

Unified memory on Apple Silicon is both VRAM and system RAM. The table below is a practical guide for what runs comfortably with Ollama or llama.cpp at 4-bit quantization (Q4_K_M).

| Mac mini RAM | Model class that fits | Quantization | Typical tokens/sec | Notes |
|---|---|---|---|---|
| 8 GB | 3B params max | Q4 | 40-60 | Fine for summarization, small agents |
| 16 GB | 7-8B params | Q4 | 30-45 | Sweet spot for Llama 3.1 8B, Qwen2.5 7B |
| 24 GB | 13-14B params | Q4 | 20-30 | Qwen2.5 14B is a sweet spot |
| 32 GB | 32B params | Q4 | 12-18 | Qwen2.5 32B, DeepSeek Coder |
| 48 GB | 34-40B params | Q4/Q5 | 10-15 | Longer contexts possible |
| 64 GB | 70B params | Q4 | 6-10 | Llama 3.3 70B with 4k-8k context |

## Rules of thumb

1. Leave 4-6 GB for macOS and other services.
2. Longer context windows need proportionally more RAM.
3. Prefer `Q4_K_M` over `Q4_0` - same size, better quality.
4. MLX can be ~20% faster than llama.cpp for the same model on the same hardware.
5. If you need 70B+ regularly, cluster multiple minis with exo instead of buying a 64 GB mini.

## Quick commands

```bash
# Check current RAM pressure
vm_stat

# Ollama model list sorted by size
ollama list | sort -k3 -h

# Pull a size-appropriate model
ollama pull qwen2.5:14b   # for 24 GB minis
```
