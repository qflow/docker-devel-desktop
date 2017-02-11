FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends xfce4 && \
    apt-get install -y tightvncserver && \
    mkdir /root/.vnc

ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN chmod 600 /root/.vnc/passwd

CMD tightvncserver :1

EXPOSE 5901
