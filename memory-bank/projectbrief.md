# Project Brief: OpenClaw Docker

## Overview
A lightweight and production-ready Docker image for OpenClaw runtime environment, pre-installed with essential system tools.

## Core Requirements
- Base image: Ubuntu 22.04
- Pre-installed tools: SSH, screen, vim, net-tools, sudo, curl, wget
- Configured for development scenarios with SSH access
- Production-ready configuration

## Key Features
- SSH server pre-configured (root password: openclaw123)
- Timezone set to Asia/Shanghai
- UTF-8 locale support
- Minimal image size with --no-install-recommends

## Repository
- Remote: git@github.com:Ts-sound/openclaw-docker.git