# Technical Context: OpenClaw Docker

## Technologies & Frameworks

### Container Technology
- **Docker**: Container runtime platform
- **Ubuntu 22.04 LTS**: Base OS image

### Installed Packages

| Package | Purpose |
|---------|---------|
| openssh-server | SSH daemon for remote access |
| screen | Terminal multiplexer for persistent sessions |
| vim | Text editor |
| net-tools | Network utilities (ifconfig, netstat, etc.) |
| sudo | Privilege escalation |
| curl | HTTP client for data transfer |
| wget | File downloader |
| tzdata | Timezone data |
| locales | Language/locale support |

### OpenClaw Installation
- **OpenClaw**: Installed via `curl -fsSL https://openclaw.ai/install.sh | bash`
- **Feishu Plugin**: `@openclaw/feishu` pre-installed

## Development Tools
- **Git**: Version control
- **Docker**: Container build and runtime

## Build Commands

```bash
# Build the image
docker build -t openclaw-docker .

# Create authorized_keys file with your public key
echo "ssh-rsa AAAA... your-public-key" > authorized_keys

# Create openclaw config directory structure
mkdir -p .openclaw/workspace

# Run a container with SSH key and openclaw config mapping
docker run -d \
  -p 2222:22 \
  -v $(pwd)/authorized_keys:/root/.ssh/authorized_keys:ro \
  -v $(pwd)/.openclaw/openclaw.json:/root/.openclaw/openclaw.json \
  -v $(pwd)/.openclaw/workspace:/root/.openclaw/workspace \
  --name openclaw \
  openclaw-docker

# SSH into the container using your private key
ssh root@localhost -p 2222 -i your_private_key
```

## Configuration Details

### Environment Variables
- `DEBIAN_FRONTEND=noninteractive` - Prevents interactive prompts during build
- `LANG=en_US.UTF-8` - System language
- `LANGUAGE=en_US:en` - Language preference
- `LC_ALL=en_US.UTF-8` - Locale settings

### Exposed Ports
- `22` - SSH port

### Volumes (mounted at runtime)
- `.openclaw/openclaw.json` → `/root/.openclaw/openclaw.json` - OpenClaw config file
- `.openclaw/workspace` → `/root/.openclaw/workspace` - OpenClaw workspace directory
- `authorized_keys` → `/root/.ssh/authorized_keys` - SSH public keys
