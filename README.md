# openclaw-docker
A lightweight and production-ready Docker image for OpenClaw runtime environment, pre-installed with essential system tools (SSH, screen, vim, net-tools/ifconfig, etc.)

## Features

- Ubuntu 22.04 LTS base image
- SSH server (key-based authentication only)
- Essential tools: screen, vim, net-tools, sudo, curl, wget
- Timezone: Asia/Shanghai
- Locale: en_US.UTF-8
- OpenClaw config directory: `/root/.openclaw`

## Quick Start

### Build the Image

```bash
docker build -t openclaw-docker .
```

### Run Container

```bash
# Create authorized_keys file with your public key
echo "ssh-rsa AAAA... your-public-key" > authorized_keys

# Create openclaw config directory structure
mkdir -p .openclaw/workspace

# Run container with SSH key and openclaw config mapping
docker run -d \
  -p 2222:22 \
  -v $(pwd)/authorized_keys:/root/.ssh/authorized_keys:ro \
  -v $(pwd)/.openclaw/openclaw.json:/root/.openclaw/openclaw.json \
  -v $(pwd)/.openclaw/workspace:/root/.openclaw/workspace \
  --name openclaw \
  openclaw-docker
```

### SSH Access

```bash
ssh root@localhost -p 2222 -i your_private_key
```

## Configuration

| Setting | Value |
|---------|-------|
| SSH Port | 22 |
| Authentication | Key-based only |
| Password Login | Disabled |
| Config Dir | `/root/.openclaw` |

## Volume Mappings

| Host Path | Container Path |
|-----------|----------------|
| `./.openclaw/openclaw.json` | `/root/.openclaw/openclaw.json` |
| `./.openclaw/workspace` | `/root/.openclaw/workspace` |
| `./authorized_keys` | `/root/.ssh/authorized_keys` |

## Security Notes

- Password authentication is disabled for security
- You must provide your SSH public key via volume mount
- Root login is allowed with key authentication only
