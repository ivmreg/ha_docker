# Dockerfiles Directory

This directory contains custom Dockerfile builds for services in the stack.

## Structure

```
dockerfiles/
├── chrony/
│   ├── Dockerfile
│   └── chrony.conf
└── [future-service]/
    ├── Dockerfile
    └── [config files]
```

## Services

### Chrony NTP Server

Located in `chrony/`, provides network time synchronization for the stack and local network.

**Build:** `docker compose build chrony`  
**Run:** `docker compose up -d chrony`

Configuration is in `chrony/chrony.conf`. Adjust the `allow` directives to match your network subnet.
