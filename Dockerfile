# 기반 이미지 설정
FROM ubuntu:22.04

# 이미지 레이블 설정
LABEL website="sangchul.kr"

# 환경 변수 설정
ARG DEBIAN_FRONTEND=noninteractive
ARG SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD:-root}

ENV SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD}
ENV TZ=Asia/Seoul

# root 권한으로 진행
USER root

# apt 패키지 매니저의 소스를 mirror.kakao.com으로 변경하고 필요한 패키지 설치
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
# 패키지 설치
RUN apt-get update \
  && apt-get update && apt-get install -y --no-install-recommends \
    systemd \
    build-essential \
    openssh-server \
    sudo \
    passwd \
    procps \
    tzdata  \
    dnsutils \
    net-tools \
    curl \
    vim \
  && apt-get clean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

RUN echo "Asia/Seoul" > /etc/timezone

# root 비밀번호 설정
RUN echo "root:$SSH_ROOT_PASSWORD" | chpasswd

# bash 프롬프트 설정
RUN echo 'export PS1="\[\e[33m\]\u\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\[\033[01;31m\]\W\[\e[m\]$ "' >> ~/.bashrc

# SSH 서버 설정
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# SSH 포트 열기
EXPOSE 22

# 컨테이너가 시작될 때 systemd를 사용하여 SSH 서버 시작
CMD ["/sbin/init"]
