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
RUN apt -y install openvpn unzip wget tilix apt-utils

# Change Background to sth cool
COPY assets/mr-robot-wallpaper.png  /usr/share/backgrounds/kali/mr-robot-wallpaper.png 
COPY assets/evil-corp.png  /usr/share/backgrounds/kali/kali-layers-16x9.png
COPY assets/mr-robot-walpaper-colored.png  /usr/share/backgrounds/kali/mr-robot-walpaper-colored.png
COPY assets/rick.png  /usr/share/backgrounds/kali/rick.png
COPY assets/wind-psych.png  /usr/share/backgrounds/kali/wind-psych.png

# Install Starship
RUN wget https://starship.rs/install.sh
RUN chmod +x install.sh
RUN ./install.sh -y

# Add Starship to bashrc
RUN echo 'eval "$(starship init bash)"' >> .bashrc

# Add Starship Theme
COPY config/starship.toml .config/starship.toml

# Install Hack Nerd Font
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
RUN unzip Hack.zip -d /usr/local/share/fonts

# Install Terminator
RUN apt -y install terminator
# Set up Nerd font in Terminator
RUN mkdir .config/terminator
COPY config/terminator.toml .config/terminator/config


# Install XFCE Dark Theme
# RUN apt -y install numix-gtk-theme


######### End Customizations ###########


RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME
