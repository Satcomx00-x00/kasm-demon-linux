FROM kasmweb/core-kali-rolling:1.12.0-rolling

USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME


######### Customize Container Here ###########

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install openvpn unzip wget apt-utils git nano


RUN echo "kasm-user:Summon" | chpasswd
RUN usermod -aG sudo kasm-user


RUN git clone https://github.com/Satcomx00-x00/Summon-for-docker.git demon 
RUN pwd
RUN ls

RUN ["/bin/bash", "-c", "demon/setup.sh "]
RUN python3 demon/summon.py install demon -u kasm-user
RUN python3 demon/summon.py install all




# Install XFCE Dark Theme
# RUN apt -y install numix-gtk-theme
######### End Customizations ###########


RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME
