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
        systemd \
        build-essential \
        openssh-server \
        sudo \
        passwd \
        procps \
        tzdata \
        dnsutils \
        net-tools \
        curl \
        vim && \
    # 타임존 설정
    echo "$TZ" > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    # SSH 설정 변경
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    # 불필요한 패키지 정리
    apt clean && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# 심볼릭 링크 생성
RUN ln -sf /lib/systemd/systemd /sbin/init

# root 비밀번호 설정
RUN echo "root:$SSH_ROOT_PASSWORD" | chpasswd

# bash 프롬프트 설정
RUN echo 'export PS1="\[\e[33m\]\u\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\[\033[01;31m\]\W\[\e[m\]$ "' >> ${HOME}/.bashrc

# SSH 포트 열기
EXPOSE 22

# systemd 활성화
CMD ["/sbin/init"]
