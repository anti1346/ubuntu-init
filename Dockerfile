FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

# Install systemd and necessary tools
RUN apt-get update && apt-get install -y systemd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up init process
CMD ["/sbin/init"]
