# 기반 이미지 설정
FROM ubuntu:24.04

# 이미지 레이블 설정
LABEL website="scbyun.com"

# 환경 변수 및 ARG 설정
ARG SSH_ROOT_PASSWORD
ENV SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD:-root}
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

# root 권한으로 진행
USER root

# 패키지 설치 및 설정
RUN apt update && \
    apt install -y --no-install-recommends \
        build-essential \
        openssh-server \
        sudo \
        passwd \
        procps \
        tzdata \
        dnsutils \
        net-tools \
        curl \
        vim \
        systemd systemd-sysv && \
    echo "$TZ" > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    apt clean && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# bash 프롬프트 설정
RUN echo 'export PS1="\[\e[33m\]\u\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\[\033[01;31m\]\W\[\e[m\]$ "' >> /root/.bashrc

# SSH 포트 열기
EXPOSE 22

# systemd 실행 설정
STOPSIGNAL SIGRTMIN+3
CMD ["/lib/systemd/systemd"]
