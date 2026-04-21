# Hardware

## Which Mac mini to buy for a home server

| Use case | Recommended mini | RAM | Storage |
|---|---|---|---|
| Light self-hosted services | M2 base | 16 GB | 512 GB |
| Media server + smart home | M2 / M4 | 16-24 GB | 1 TB + external |
| Agentic AI (7-14B models) | M4 | 24-32 GB | 1 TB + external |
| Agentic AI (32-70B models) | M4 Pro | 48-64 GB | 1-2 TB + external |
| iOS/macOS CI runner | M2 Pro / M4 Pro | 32 GB | 1 TB |

Storage tip: buy the smallest internal SSD you can live with and use Thunderbolt external NVMe for media libraries and backups. Internal storage is the most expensive upgrade Apple sells.

## Accessories that matter

- **UPS** - CyberPower CP685AVRLCD or APC BE850M2 with NUT for clean shutdown on power loss
- **Thunderbolt dock** - OWC Thunderbolt 4 Dock for 10GbE + multi-drive expansion
- **External NVMe** - Samsung T9 or ACASIS 40Gbps enclosure with a WD SN850X
- **Headless display dongle** - only needed on pre-M1 minis; Apple Silicon does not require it
- **Rack mount** - geerlingguy/mini-rack 10-inch open-source designs

## Network

- Use Ethernet, not Wi-Fi. Ethernet halves tail latency on local LLM API calls.
- On M4 Pro, the 10GbE option is worth it if you have a 10GbE switch or NAS.
- For smart home, keep the mini on the same VLAN as your IoT devices or bridge them.

## Placement

- Closet with passive airflow is fine. Fan almost never spins under home-server loads.
- Avoid stacking heat-generating devices underneath.
- Keep the USB-C ports accessible for occasional keyboard or serial work.
