FROM ubuntu:16.04

RUN apt-get update && apt-get install -y inotify-tools openssh-server nano $

RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/$

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginu$

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

RUN mkdir /source
RUN mkdir /target

WORKDIR /tmp
ADD script.sh /tmp

CMD /tmp/script.sh ; sleep infinity
