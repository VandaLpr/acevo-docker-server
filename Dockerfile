FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEPREFIX=/wine
ENV WINEARCH=win64

RUN dpkg --add-architecture i386 && \
    apt update && \
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -pm755 /etc/apt/keyrings && \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
    wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

RUN apt update && \
    apt install -y --install-recommends \
    winehq-stable \
    winetricks \
    xvfb \
    cabextract \
    unzip

RUN mkdir /server /wine
WORKDIR /server

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 9700/tcp
EXPOSE 9700/udp

CMD ["/start.sh"]
