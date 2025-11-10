# Observability Stack for Home Lab

This repository provides a complete observability stack for Windows/WSL2 home labs. It combines log aggregation (Loki + Promtail), metrics collection (Prometheus), visualization (Grafana), and time synchronization (Chrony) in a single Docker Compose deployment.

## Stack Components

- **Loki** - Log aggregation system
- **Promtail** - Syslog receiver and log shipper (TCP/UDP 514, 1514)
- **Prometheus** - Metrics collection and time-series database
- **Grafana** - Unified dashboard and exploration UI
- **Chrony** - NTP server for network time synchronization

## Repository Layout

```
compose.yaml             # Docker Compose orchestration
config/                  # Service configurations
  ├── grafana/           # Grafana provisioning (datasources)
  ├── loki/              # Loki storage & schema config
  ├── prometheus/        # Prometheus scrape targets
  └── promtail/          # Promtail syslog & pipeline config
dockerfiles/             # Custom Docker builds
  ├── chrony/            # NTP server Dockerfile & config
  └── promtail/          # Custom Promtail build (optional)
scripts/                 # Helper scripts for local workflows
```

## Prerequisites

- Windows 10/11 with WSL2 enabled
- Docker Desktop (integrated with WSL2)
- Minimum 4GB RAM allocated to Docker

## Getting Started

1. Clone the repository:
   ```bash
   cd /c/Users/YourName/git
   git clone <repo-url> ha_docker
   cd ha_docker
   ```

2. Start the stack:
   ```bash
   docker compose up -d
   ```

3. Access the services:
   - **Grafana**: http://localhost:3000 (admin/admin)
   - **Prometheus**: http://localhost:9090
   - **Loki**: http://localhost:3100
   - **Promtail Metrics**: http://localhost:9080/metrics

4. Configure your devices to send syslog to your host IP:
   - TCP: port 514 or 1514
   - UDP: port 514

## Service Configuration

### Syslog Ingestion (Promtail)

Edit `config/promtail/promtail.yaml` to:
- Add pipeline stages for parsing
- Configure label extraction
- Adjust syslog format (RFC3164/RFC5424)

### Metrics Collection (Prometheus)

Edit `config/prometheus/prometheus.yml` to:
- Add new scrape targets
- Adjust scrape intervals
- Configure alerting rules

### Log Storage (Loki)

Edit `config/loki/loki-config.yml` to:
- Modify retention periods
- Tune chunk sizes
- Configure compaction settings

### Time Synchronization (Chrony)

Edit `dockerfiles/chrony/chrony.conf` to:
- Adjust allowed networks (`allow` directives)
- Change NTP server pools
- Enable/disable logging

## Metrics & Monitoring

All services expose Prometheus-compatible metrics:

- **Loki**: `http://localhost:3100/metrics`
- **Promtail**: `http://localhost:9080/metrics`
- **Prometheus**: `http://localhost:9090/metrics`
- **Grafana**: `http://localhost:3000/metrics`

Prometheus automatically scrapes these endpoints. View them in Grafana by adding Prometheus as a data source.

## Development Tips

- View logs: `docker compose logs -f [service-name]`
- Rebuild custom images: `docker compose build [service-name]`
- Restart after config changes: `docker compose restart [service-name]`
- Check container status: `docker compose ps`
- Run diagnostics: `scripts/wsl2-docker-diagnose.sh`

## Troubleshooting

### Syslog not receiving messages
- Check firewall rules for ports 514/1514
- Verify device is sending to correct IP
- Check promtail logs: `docker compose logs promtail`

### Prometheus permission errors
- Ensure `prometheus-data/` directory exists
- Container runs as root (user: "0") to avoid WSL2 permission issues

### Grafana datasource connection failed
- Verify Loki is running: `docker compose ps loki`
- Check datasource config: `config/grafana/provisioning/datasources/loki.yml`

## Data Persistence

The following directories store persistent data:
- `grafana-data/` - Grafana dashboards, users, settings
- `loki-data/` - Loki log chunks and indexes
- `prometheus-data/` - Prometheus time-series database
- `chrony-data/` - Chrony drift files

**Backup these directories** to preserve your data.

## Security Considerations

- Change default Grafana credentials immediately
- Restrict syslog listener to your local network
- Consider adding authentication to Prometheus/Loki
- Review allowed networks in Chrony config
