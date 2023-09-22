# after-installation-ubuntu

What do we need after installation ubuntu?

Ubuntu version: 22.04

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

## Install Terminator
```bash
sudo apt-get update
sudo apt-get install terminator
```
## Install screen shot tools
```bash
sudo apt install flameshot
```
## Install internet download manager (XDM)
```bash
wget https://github.com/subhra74/xdm/releases/download/7.2.11/xdm-setup-7.2.11.tar.xz
tar -xf xdm-setup-*.tar.xz
sudo ./install.sh
xdman
```
# Gnome extensions
## Install clipboard-indicator
https://extensions.gnome.org/extension/779/clipboard-indicator/
## Install net-speed-simplified
https://extensions.gnome.org/extension/3724/net-speed-simplified/
## Install timezones-extension
https://extensions.gnome.org/extension/2657/timezones-extension/


# Install nodejs with nvm
https://github.com/nvm-sh/nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

source ~/.zshrc
```

# Calling nvm use automatically in a directory with a .nvmrc file
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


# Install docker and docker-compose
https://docs.docker.com/engine/install/ubuntu/
https://docs.docker.com/compose/install/

Giving non-root access to docker
```bash
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
```
need log out

## Install DB with docker-compose
mongoDB
```bash
cd ./mongo
docker-compose up --build -d 
```

postgres and pgadmin
```bash
cd ./postgres
docker-compose up --build -d 
cd ../pgadmin
docker-compose up --build -d 
```

redis
```bash
cd redis
docker-compose up --build -d 
```


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


# All in one script
Under dev


# TODO
- [] Mongo DB compass

- [] Postman

- [] Nvm

- [*] Screen shot

- [] Screen recorder

- [] Any desk

- [] All in one script

- [] All in one script(selectable)
