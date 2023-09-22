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

# Gnome extensions
## Install clipboard-indicator
https://extensions.gnome.org/extension/779/clipboard-indicator/

## Install clipboard-indicator


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

# Install messaging social platform
https://discord.com/download

https://slack.com/downloads/linux


# All in one script



# TODO
Mongo DB compass
Postman
nvm
screen shot
screen recorder
any desk
All in one script
All in one script(selectable)