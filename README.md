# After Installation Ubuntu Setup Guide

What do we need after installation ubuntu?

**Ubuntu version:** 24.04

## 📋 Table of Contents

- [System Setup & Updates](#system-setup--updates)
- [Shell & Terminal](#shell--terminal)
- [Development Tools](#development-tools)
- [Database & Data Management](#database--data-management)
- [Media & Recording Tools](#media--recording-tools)
- [File Transfer & Management](#file-transfer--management)
- [Web Browsers](#web-browsers)
- [Communication Tools](#communication-tools)
- [Gnome Extensions](#gnome-extensions)
- [Docker Services](#docker-services)
- [Useful Commands](#useful-commands)
- [TODO](#todo)

## 🔧 System Setup & Updates

### Update Ubuntu
```bash
sudo apt-get update
```

### Install curl
```bash
sudo apt install curl
```

### Install git and git-flow
```bash
sudo apt install git
sudo apt install git-flow
```

### Configure git 
```bash
git config --global user.name "your_name"
git config --global user.email "email@address.com"
git config --list
```

## 🖥️ Shell & Terminal

### Install Zsh & Oh My Zsh

https://www.sitepoint.com/zsh-tips-tricks/

#### Oh My Zsh plugins

https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins

##### Docker plugins
- https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
- https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose

##### Node.js plugins
- https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
- https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
- https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pm2

### Install Terminator
```bash
sudo apt-get update
sudo apt-get install terminator
```

## 💻 Development Tools

### Install Node.js with nvm
https://github.com/nvm-sh/nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
```

#### Calling nvm use automatically in a directory with a .nvmrc file
Put this into `.zshrc`:
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

### Install PM2
```bash
npm install pm2 -g
```

### Install Go
```bash
# Download and install Go (replace with latest version)
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
```

Add Go to your PATH by adding this to your `.zshrc` or `.bashrc`:
```bash
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

Then reload your shell:
```bash
source ~/.zshrc
```

Verify installation:
```bash
go version
```

### Install Docker and Docker Compose
https://docs.docker.com/engine/install/ubuntu/

#### Give non-root access to docker
```bash
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
```
*May need restart*

### Install VS Code
https://code.visualstudio.com/Download

### Install Postman
```bash
sudo snap install postman
```

### Install internet download manager (XDM)
```bash
wget https://github.com/subhra74/xdm/releases/download/7.2.11/xdm-setup-7.2.11.tar.xz
tar -xf xdm-setup-*.tar.xz
sudo ./install.sh
xdman
```

## 🗄️ Database & Data Management

### Install MongoDB Compass
https://www.mongodb.com/try/download/compass

### Install Redis Insight
```bash
sudo snap install redis-insight
```
*Alternative: Download from https://redis.com/redis-enterprise/redis-insight/*

### Install DBeaver
```bash
sudo snap install dbeaver-ce
```
*Alternative: Download from https://dbeaver.io/download/*

## 🎥 Media & Recording Tools

### Install Flameshot (Screenshot tool)
```bash
sudo apt install flameshot
```

### Install OBS Studio (Screen recorder & streaming)
```bash
sudo apt install obs-studio
```
*Alternative via snap:*
```bash
sudo snap install obs-studio
```

### Install Kazam (Screen recorder)
Install it from App Center

## 📁 File Transfer & Management

### Install FileZilla
```bash
sudo apt install filezilla
```

## 🌐 Web Browsers

### Install Google Chrome
```bash
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
```
*Alternative: Download .deb from https://www.google.com/chrome/*

## 💬 Communication Tools

### Install Discord
https://discord.com/download

### Install Slack
https://slack.com/downloads/linux

## 🔧 Gnome Extensions

https://wiki.gnome.org/action/show/Projects/GnomeShellIntegration/Installation?action=show&redirect=Projects%2FGnomeShellIntegrationForChrome%2FInstallation

### Install clipboard-indicator
https://extensions.gnome.org/extension/779/clipboard-indicator/

### Install net-speed
- https://extensions.gnome.org/extension/3724/net-speed-simplified/
- https://extensions.gnome.org/extension/4478/net-speed/

### Install utc-clock
https://extensions.gnome.org/extension/6409/utc-clock/

## 🐳 Docker Services

### MongoDB
```bash
cd ./docker/mongo
docker compose up -d 
```

### PostgreSQL and pgAdmin
```bash
cd ./docker/postgres
docker compose up -d 
cd ../pgadmin
docker compose up -d 
```

### Redis
```bash
cd ./docker/redis
docker compose up -d 
```

## 🛠️ Useful Commands

### Enable seconds on the clock
```bash
gsettings set org.gnome.desktop.interface clock-show-seconds true
```

## 🚀 Automated Installation

For an interactive installation experience, run the automated installation script:

```bash
chmod +x install.sh
./install.sh
```

This script allows you to select which applications and tools you want to install.
