FROM osrf/ros:noetic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    software-properties-common \
    pwgen \
    tzdata \
    psmisc \
    net-tools \
    tigervnc-common \
    tigervnc-standalone-server \
    jwm \
    wget \
    xterm \
    nano \
    expect \
    unzip \
    lxterminal \
    x11-xserver-utils \
    git \
    python \
    python-numpy \
    && rm -rf /var/lib/apt/lists/*

# Use bash
SHELL ["/bin/bash", "-c"]

# Setup VNC server

COPY start_vnc.sh /

ENV TZ=Europe/London

RUN chmod 777 /*.sh && \
    cd /opt && wget https://github.com/novnc/noVNC/archive/v1.0.0.tar.gz -O /tmp/webvnc-v1.0.0.tar.gz && \
    tar xvfz /tmp/webvnc-v1.0.0.tar.gz && \   
    ln -s /opt/noVNC-1.0.0/vnc.html /opt/noVNC-1.0.0/index.html && \
    mkdir -p /ardupilot/.config/lxterminal && \
    update-alternatives --set x-terminal-emulator /usr/bin/lxterminal

    #&& chown -R ardupilot:ardupilot /opt/* && \

COPY set_vnc_password.sh /opt
COPY system.jwmrc /etc/jwm
COPY lxterminal.conf /home/vnc/.config/lxterminal
COPY move.py /


# Define shell scripts used to start Gazebo and SITL
COPY ./start_turtle.sh /start_turtle.sh
RUN chmod +x /start_turtle.sh

# expose port 80 for the web server
EXPOSE 8000

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
