FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    git \
    build-essential \
    curl \
    wget \
    nano \
    nodejs \
    npm \
    python3 \
    python3-pip \
    ca-certificates \
    sudo

# create user
RUN useradd -ms /bin/bash dev
RUN usermod -aG sudo dev
RUN echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# we must be root to modify system files
USER root

# Disable default motd scripts
RUN chmod -x /etc/update-motd.d/*

# Create our own motd generator
RUN echo '#!/bin/bash' > /etc/update-motd.d/01-custom && \
    echo 'echo -e "\e[1;32m Welcome to a Linux dev container\e[0m"' >> /etc/update-motd.d/01-custom && \
    chmod +x /etc/update-motd.d/01-custom

# IMPORTANT: actually generate /etc/motd
RUN run-parts /etc/update-motd.d > /etc/motd

USER dev
WORKDIR /home/dev

# make bash behave like a login shell and show banner
RUN echo 'cat /etc/motd' > /home/dev/.bash_profile && \
    echo 'source ~/.bashrc' >> /home/dev/.bash_profile
    CMD ["/bin/bash", "-l"]


# container identity
RUN echo '' >> /home/dev/.bashrc && \
    echo '# Container warning' >> /home/dev/.bashrc && \
    echo 'echo -e "\e[1;31m[ Marex Dev Container ]\e[0m"' >> /home/dev/.bashrc && \
    echo 'echo "All changes outside /workspace will be lost."' >> /home/dev/.bashrc

# red prompt for containers
RUN echo "PS1='\[\e[1;31m\]\u@\h\[\e[0m\]:\[\e[33m\]\w\[\e[0m\]$ '" >> /home/dev/.bashrc
