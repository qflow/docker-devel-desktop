FROM nvidia/cuda:9.2-devel-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root
ENV GEOMETRY 1366x768

RUN apt-get update && \
    tasksel install xubuntu-desktop && \
    apt-get install -y wget chromium-browser && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /root/.vnc

ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN chmod 600 /root/.vnc/passwd && chmod 755 /root/.vnc/xstartup

WORKDIR /home/root/Downloads
RUN wget https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.7.1.x86_64.tar.gz -O tigervnc-1.7.1.x86_64.tar.gz && \
    tar zxf tigervnc-1.7.1.x86_64.tar.gz && cp -R tigervnc-1.7.1.x86_64/usr/bin/* /usr/bin

WORKDIR /tools
RUN wget -O KDevelop.AppImage https://download.kde.org/stable/kdevelop/5.1.1/bin/linux/KDevelop-5.1.1-x86_64.AppImage && \
    chmod +x KDevelop.AppImage
#RUN add-apt-repository -y ppa:blaze/kf5 && \
#    apt update && \
#    apt install -y kdevelop

CMD bash -c "vncserver -kill :1; vncserver :1 -geometry $GEOMETRY -depth 24 && tail -F /root/.vnc/*.log"

EXPOSE 5901
