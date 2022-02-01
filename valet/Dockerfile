FROM ubuntu:21.10

ENTRYPOINT /bin/bash
EXPOSE 3000
ENV PATH=$PATH:/usr/local/bin:/home/valet/.config/composer/vendor/bin
ENV USER=valet

# Get the latest packages
RUN apt update

# Update all the packages
RUN apt upgrade -y

# The ability to add custom repositories
RUN apt install -y software-properties-common

# Get access to PHP repositories
RUN add-apt-repository ppa:ondrej/php

# Node needed to install and build frontends 
RUN apt install -y \
    nodejs npm

# Install some general tools that are useful
RUN apt install -y \
    git curl nano htop sudo wget net-tools make zip \
    mysql-client network-manager libnss3-tools jq xsel

# PDF and Image manipulation
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb
RUN apt install -y ./wkhtmltox_0.12.6-1.focal_amd64.deb
RUN apt install -y pdftk
RUN apt install -y inkscape
RUN apt install -y ghostscript
RUN apt install -y texlive-full
RUN apt install -y potrace

# PHP needed to use composer, to install valet
RUN apt install -y \
    php7.4-cli php7.4-curl php7.4-mcrypt php7.4-mbstring php7.4-bcmath php7.4-xml php7.4-zip php7.4-mysql php7.4-sqlite3 php7.4-gd php7.4-imagick \
    php8.0-cli php8.0-curl php8.0-mcrypt php8.0-mbstring php8.0-bcmath php8.0-xml php8.0-zip php8.0-mysql php8.0-sqlite3 php8.0-gd php8.0-imagick

# Download and install composer
RUN curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Add the defined user and give sudo access
RUN groupadd valet
RUN useradd -m -s /bin/zsh -g valet valet
RUN passwd -d valet
RUN usermod -G sudo valet

# Prevent the ask of sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> \
    /etc/sudoers

# Add prerequisite runtime directories and permissions
RUN mkdir -p /run/php
RUN chown -R valet:valet /run/php

USER valet
WORKDIR /home/valet

# Download and install ohmybash
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Download and install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Install yarn package
RUN sudo npm install -g yarn

# Install valet package
RUN composer global require cpriego/valet-linux 2.2.17

# Update permissions on update script to prevent permission denied issue
RUN chown -R valet:valet /home/valet/.config
RUN chmod -R a+x .config/composer/vendor/cpriego/valet-linux

# Run the installation
RUN .config/composer/vendor/bin/valet install
