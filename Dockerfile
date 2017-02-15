FROM qflow/ubuntu-video-processing

ENV DEBIAN_FRONTEND noninteractive
ENV USER root
ENV GEOMETRY 1366x768

RUN apt-get update && \
    apt-get install -y xubuntu-desktop xfce4-goodies && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
    apt-get install -y wget x11vnc fuse firefox && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /root/.vnc

ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN chmod 600 /root/.vnc/passwd
RUN chmod 755 /root/.vnc/xstartup

WORKDIR /tools
RUN wget -O KDevelop.AppImage http://download.kde.org/stable/kdevelop/5.0.3/bin/linux/KDevelop-5.0.3-x86_64.AppImage
RUN chmod +x KDevelop.AppImage

CMD /usr/bin/vncserver :1 -geometry $GEOMETRY -depth 24 -dpi 100 && tail -f /root/.vnc/*:1.log

EXPOSE 5901
