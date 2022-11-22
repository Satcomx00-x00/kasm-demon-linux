FROM kasmweb/core-kali-rolling:1.11.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME


######### Customize Container Here ###########

RUN apt update
# RUN apt -y upgrade
RUN apt -y install apt-utils
RUN apt -y install openvpn unzip wget apt-utils git nano


RUN useradd invoker -m -s /bin/bash
RUN echo "invoker:Summon" | chpasswd
RUN usermod -aG sudo invoker

RUN cd /opt && git clone https://github.com/Satcomx00-x00/Summon-for-docker.git demon && cd demon && ./setup.sh

RUN pwd
RUN ls
RUN cd /opt/Summon-for-docker/demon && python3 summon.py install demon -u invoker

# make a reboot in compile time
RUN echo "reboot" >> /etc/rc.local
RUN python3 summon.py install all

# Install XFCE Dark Theme
# RUN apt -y install numix-gtk-theme


######### End Customizations ###########


RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME
