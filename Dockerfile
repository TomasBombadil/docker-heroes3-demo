FROM ubuntu:14.04

RUN apt-get update 
RUN apt-get install -y curl gnupg wget git
#ADD http://download.opensuse.org/repositories/home:/felfert/Debian_6.0/Release.key /Release.key
#RUN cat /Release.key | apt-key add - && \
#   echo "deb http://download.opensuse.org/repositories/home:/felfert/xUbuntu_12.04 ./" >> /etc/apt/sources.list.d/freerdp.list && \
#    apt-get update && \
#RUN echo 'deb http://download.opensuse.org/repositories/home:/felfert/xUbuntu_12.04/ /' | tee /etc/apt/sources.list.d/home:felfert.list
#RUN curl -fsSL https://download.opensuse.org/repositories/home:felfert/xUbuntu_12.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home:felfert.gpg > /dev/null

WORKDIR /home

RUN git clone https://github.com/FreeRDP/FreeRDP-WebConnect
WORKDIR /home/FreeRDP-WebConnect
#RUN chmod 777 ./install_prereqs.sh && ./install_prereqs.sh
RUN chmod 777 ./setup-all.sh && ./setup-all.sh -f -i -d

#RUN apt-get update
#RUN apt-get install -y wsgate
    
RUN rm /etc/wsgate.ini && \
    echo "[global]" >> /etc/wsgate.ini && \
    echo "port = 80" >> /etc/wsgate.ini && \
    echo "debug = true" >> /etc/wsgate.ini && \
    echo "[http]" >> /etc/wsgate.ini && \
    echo "documentroot = /usr/share/wsgate" >> /etc/wsgate.ini

EXPOSE 80

CMD wsgate --foreground