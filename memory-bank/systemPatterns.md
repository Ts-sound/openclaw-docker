# System Patterns: OpenClaw Docker

## Architecture
Single-container Docker image based on Ubuntu 22.04 LTS.

## Design Patterns

### Container Pattern
- **Base Image**: Ubuntu 22.04 (LTS for stability)
- **Single Process**: SSH daemon as the main process (PID 1)
- **Foreground Mode**: SSH runs with `-D` flag to keep container alive

### Configuration Pattern
- **Environment Variables**: Used for non-interactive installation (`DEBIAN_FRONTEND=noninteractive`)
- **Layer Optimization**: Related commands grouped in single RUN instruction to minimize layers
- **Cleanup Pattern**: `apt-get clean` and `rm -rf /var/lib/apt/lists/*` to reduce image size

## Key Components

### SSH Configuration
- Root login allowed with key-based authentication only
- Password authentication disabled for security
- Public key authentication enabled
- PAM disabled for simpler authentication
- Default port: 22

### System Configuration
- Timezone: Asia/Shanghai
- Locale: en_US.UTF-8
- Config directory: `/root/.openclaw` (pre-created)

### Volume Configuration (mounted at runtime)
- `.openclaw/openclaw.json` → `/root/.openclaw/openclaw.json` - OpenClaw config file
- `.openclaw/workspace` → `/root/.openclaw/workspace` - OpenClaw workspace directory
- `authorized_keys` → `/root/.ssh/authorized_keys` - SSH public keys

## Build Patterns
- Uses `--no-install-recommends` to minimize package installation
- Multi-command RUN layers for efficiency