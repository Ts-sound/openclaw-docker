FROM ubuntu:22.04

LABEL description="Docker image for OpenClaw with essential tools pre-installed"

# 设置非交互式安装，避免安装过程中弹出交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新软件源并安装所需工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server screen vim net-tools \
    sudo curl wget tzdata locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 配置 SSH 服务（仅允许密钥登录，禁用密码登录）
RUN mkdir /var/run/sshd \
    && mkdir -p /root/.ssh \
    && chmod 700 /root/.ssh \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# 配置时区（可选，避免容器时区混乱）
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

# 配置字符编码（避免中文乱码）
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# 创建 openclaw 配置目录
RUN mkdir -p /root/.openclaw

# 暴露 SSH 端口
EXPOSE 22

# 启动 SSH 服务（前台运行，保证容器不退出）
CMD ["/usr/sbin/sshd", "-D"]