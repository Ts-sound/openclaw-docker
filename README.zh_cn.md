# openclaw-docker

**中文** | [English Documentation](README.md)

轻量级且生产就绪的 OpenClaw 运行环境 Docker 镜像，预装了必要的系统工具（SSH、screen、vim、net-tools/ifconfig 等）

## 功能特性

- Ubuntu 22.04 LTS 基础镜像
- SSH 服务器（仅支持密钥认证）
- 必要工具：screen, vim, net-tools, sudo, curl, wget
- OpenClaw 预安装（通过 https://openclaw.ai/install.sh）
- 飞书插件预安装（`@openclaw/feishu`）
- 时区：Asia/Shanghai
- 语言环境：en_US.UTF-8
- OpenClaw 配置目录：`/root/.openclaw`

## 快速开始

### 构建镜像

```bash
docker build -t openclaw-docker .
```

### 运行容器

```bash
# 创建包含公钥的 authorized_keys 文件
echo "ssh-rsa AAAA... your-public-key" > authorized_keys

# 创建 openclaw 配置目录结构
mkdir -p .openclaw/workspace

# 使用 SSH 密钥和 openclaw 配置映射运行容器
docker run -d \
  -p 2222:22 \
  -v $(pwd)/authorized_keys:/root/.ssh/authorized_keys:ro \
  -v $(pwd)/.openclaw/openclaw.json:/root/.openclaw/openclaw.json \
  -v $(pwd)/.openclaw/workspace:/root/.openclaw/workspace \
  --name openclaw \
  openclaw-docker
```

### SSH 访问

```bash
ssh root@localhost -p 2222 -i your_private_key
```

## 配置

| 设置 | 值 |
|------|-----|
| SSH 端口 | 22 |
| 认证方式 | 仅密钥 |
| 密码登录 | 已禁用 |
| 配置目录 | `/root/.openclaw` |

## 卷映射

| 主机路径 | 容器路径 |
|----------|----------|
| `./.openclaw/openclaw.json` | `/root/.openclaw/openclaw.json` |
| `./.openclaw/workspace` | `/root/.openclaw/workspace` |
| `./authorized_keys` | `/root/.ssh/authorized_keys` |

## 安全说明

- 密码认证已禁用以提高安全性
- 必须通过卷挂载提供 SSH 公钥
- 仅允许使用密钥认证的 root 登录

## CI/CD

本项目使用 GitHub Actions 自动构建并推送镜像到 GHCR（GitHub Container Registry）。

### 工作流

`ci-docker-publish.yml` 工作流自动：
- 在 git 标签时构建 Docker 镜像
- 推送镜像到 `ghcr.io`

### 触发条件

| 事件 | 生成的标签 |
|------|------------|
| Git 标签（如 v1.2.3） | `ghcr.io/owner/openclaw-docker:v1.2.3` + `latest` |

### 镜像仓库

镜像推送到：
```
ghcr.io/ts-sound/openclaw-docker:<tag>
ghcr.io/ts-sound/openclaw-docker:latest
```

### 拉取镜像

```bash
# 拉取最新版本
docker pull ghcr.io/ts-sound/openclaw-docker:latest

# 拉取指定版本
docker pull ghcr.io/ts-sound/openclaw-docker:v1.0.0
```

## 许可证

MIT
