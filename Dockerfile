FROM ubuntu:latest
LABEL org.opencontainers.image.authors="st89382000@gmail.com"
EXPOSE 22
VOLUME /root/.ssh

RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh
RUN apt update
RUN apt install -y openssh-server
RUN apt install -y nano
RUN apt install -y nmap

RUN echo "Port 22" >> /etc/ssh/sshd_config
RUN echo "AddressFamily any" >> /etc/ssh/sshd_config
RUN echo "ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config
RUN echo "ListenAddress ::" >> /etc/ssh/sshd_config

RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
# RUN echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config
RUN echo "TCPKeepAlive yes" >> /etc/ssh/sshd_config
# RUN echo "Banner /banner.txt" >> /etc/ssh/sshd_config

#CMD ["tail", "-f" ,"/dev/null"]
#CMD ["etc/init.d/ssh", "start", "-D"]
COPY ./banner.txt /etc/motd
RUN rm /etc/update-motd.d/*
RUN echo "" > /etc/legal
COPY ./enterpoint.sh /enterpoint.sh

ENTRYPOINT [ "sh", "enterpoint.sh" ]