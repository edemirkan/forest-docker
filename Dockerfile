# Set the base image to Ubuntu
FROM steamcmd/steamcmd:ubuntu-24

# File Author / Maintainer
LABEL maintainer="edemirkan"

# Set environment variables
ENV TIMEZONE=America/Toronto
ENV DEBIAN_FRONTEND=noninteractive
ENV USER=forest
ENV HOME=/data
ENV PUID=1000

################## BEGIN INSTALLATION ######################

# Create the application user
RUN userdel -r $(getent passwd $UID | cut -d: -f1) \
 && useradd -u $UID -m -d $HOME $USER

# Create required directories
RUN mkdir -p $HOME/saves $HOME/config

# Install prerequisites
RUN apt-get update -y \
 && apt-get install -y winbind wine-stable xvfb \
 && rm -rf /var/lib/apt/lists/*

# Download the application via steamcmd
RUN steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir $HOME +login anonymous +app_update 556450 validate +quit

# Copy configuration
COPY config/server.cfg $HOME/config/server.cfg
COPY entrypoint.sh   $HOME/entrypoint.sh

##################### INSTALLATION END #####################

# Expose the default ports
EXPOSE 8766/udp 8766/tcp 27015/udp 27015/tcp 27016/udp 27016/tcp

# Correct file permissions
RUN chown -R $USER $HOME/saves $HOME/config \
 && chmod +x $HOME/entrypoint.sh \
 && ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
 && echo $TIMEZONE > /etc/timezone

# Switch to user
USER $USER

# Working directory
WORKDIR $HOME

# Set default container command
ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
