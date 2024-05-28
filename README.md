# after-installation-ubuntu

What do we need after installation ubuntu?

Ubuntu version: 24.04

# Update ubuntu
```bash
sudo apt-get update
```
## install curl
```bash
sudo apt install curl
```

# Install git
```bash
sudo apt install git
```

## Configuring git 
```bash
git config --global user.name "your_name"
git config --global user.email "email@address.com"
git config --list
```

# Install some useful tools
## Install Zsh & Oh My Zsh

https://www.sitepoint.com/zsh-tips-tricks/

### Oh My Zsh plugins

https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins

#### docker

https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose

#### node
https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pm2

## Install Terminator
```bash
sudo apt-get update
sudo apt-get install terminator
```
## Install screen shot tools
```bash
sudo apt install flameshot
```

## Install screen recorder kazam
install it from App Center

## Install internet download manager (XDM)
```bash
wget https://github.com/subhra74/xdm/releases/download/7.2.11/xdm-setup-7.2.11.tar.xz
tar -xf xdm-setup-*.tar.xz
sudo ./install.sh
xdman
```
# Gnome extensions
https://wiki.gnome.org/action/show/Projects/GnomeShellIntegration/Installation?action=show&redirect=Projects%2FGnomeShellIntegrationForChrome%2FInstallation
## Install clipboard-indicator
https://extensions.gnome.org/extension/779/clipboard-indicator/
## Install net-speed
https://extensions.gnome.org/extension/3724/net-speed-simplified/
https://extensions.gnome.org/extension/4478/net-speed/
## Install utc-clock
https://extensions.gnome.org/extension/6409/utc-clock/


# Install nodejs with nvm
https://github.com/nvm-sh/nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

source ~/.zshrc
```

## Calling nvm use automatically in a directory with a .nvmrc file
Put this into `.zshrc`
```bash
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
```

# Install PM2
```bash
npm install pm2 -g
```


# Install docker and docker-compose
https://docs.docker.com/engine/install/ubuntu/


Giving non-root access to docker
```bash
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
```
May needs restart

## Install DB with docker compose
mongoDB
```bash
cd ./mongo
docker compose up -d 
```

postgres and pgadmin
```bash
cd ./postgres
docker compose up -d 
cd ../pgadmin
docker compose up -d 
```

redis
```bash
cd redis
docker compose up -d 
```


# Install Mongo Compass
https://www.mongodb.com/try/download/compass

# Install IDE
https://code.visualstudio.com/Download

# Install postman
```bash
sudo snap install postman
```

# Install filezilla
```bash
sudo apt install filezilla
```

# Install messaging social platform
https://discord.com/download

https://slack.com/downloads/linux


## Useful commands:

Enable second on the clock
```bash
gsettings set org.gnome.desktop.interface clock-show-seconds true
```
# All in one script
Under dev


# TODO

- [] Any desk

- [] Useful commands

- [] All in one script

- [] All in one script(selectable)
