FROM qflow/ubuntu-video-processing

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends xfce4 && \
    apt-get install -y wget tightvncserver fuse && \
    mkdir /root/.vnc

ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN chmod 600 /root/.vnc/passwd
RUN chmod 755 /root/.vnc/xstartup

WORKDIR /tools
RUN wget -O KDevelop.AppImage http://download.kde.org/stable/kdevelop/5.0.3/bin/linux/KDevelop-5.0.3-x86_64.AppImage
RUN chmod +x KDevelop.AppImage

CMD /usr/bin/vncserver :1 -geometry 1920x1080 -depth 24 && tail -f /root/.vnc/*:1.log

EXPOSE 5901
