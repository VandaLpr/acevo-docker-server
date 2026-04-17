FROM ich777/winehq-baseimage

LABEL org.opencontainers.image.authors="marko@fabulic.eu"
LABEL org.opencontainers.image.source="https://github.com/Vandalpr/acevo-docker-server"

ENV DATA_DIR="/acevo"
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USER="acevo"
ENV DATA_PERM=770

# Install winetricks
RUN apt-get update && apt-get install -y winetricks && rm -rf /var/lib/apt/lists/*


# Create data dir + user
RUN mkdir $DATA_DIR && \
    useradd -d $DATA_DIR -s /bin/bash $USER && \
    chown -R $USER $DATA_DIR && \
    ulimit -n 2048

# Copy scripts
ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

WORKDIR $DATA_DIR

# Ports
EXPOSE 9700/tcp
EXPOSE 9700/udp

# Start
ENTRYPOINT ["/opt/scripts/start.sh"]
