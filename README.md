# Loki-Powered Syslog Stack

This repository turns a single syslog listener into a complete Grafana Loki stack suitable for Windows/WSL2 labs. Promtail listens for RFC5424 syslog traffic on TCP and UDP 514, forwards logs into a self-hosted Loki instance, and Grafana provides an out-of-the-box web UI for exploration.

## Repository layout

```
compose.yaml             # Docker Compose entry point
.env.example             # Root-level environment variables
services/
  syslog/                # Promtail-based syslog gateway
  loki/                  # Loki single-binary configuration
  grafana/               # Grafana provisioning (datasource)
scripts/                 # Helper scripts for local workflows
```

## Prerequisites

- Windows 10/11 with WSL2 enabled
- Docker Desktop (integrated with the target WSL2 distribution)

## Getting started

1. Copy `.env.example` to `.env` and adjust any ports, credentials, or retention values.
2. Launch the stack:
   ```bash
   docker compose up --build
   ```
3. Send syslog traffic to the host IP on TCP/UDP 514.
4. Open Grafana at `http://localhost:3000` (default creds `admin` / `change-me`) and use **Explore** to query the pre-provisioned Loki datasource.

## Customization

- Tune `services/syslog/promtail.yaml` to enrich labels, add parsing stages, or secure the listener.
- Adjust retention, chunking, or storage paths via `services/loki/loki-config.yml`.
- Extend Grafana provisioning (dashboards, alerting) under `services/grafana/provisioning`.

## Development tips

- If you change environment variables inside `.env`, restart the stack so Loki/Promtail pick them up.
- Promtail and Loki expose metrics at `http://localhost:9080/metrics` and `http://localhost:3100/metrics` for troubleshooting.
- Run `scripts/wsl2-docker-diagnose.sh` from a WSL shell whenever Docker connectivity inside WSL2 is questionable.
