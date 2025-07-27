 #!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_header() {
    echo -e "${PURPLE}${1}${NC}"
    echo "=================================================="
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if package is installed
package_installed() {
    dpkg -l | grep -q "^ii  $1 "
}

# Check if snap package is installed
snap_installed() {
    snap list | grep -q "^$1 "
}

# Update system
update_system() {
    log_info "Updating system packages..."
    sudo apt-get update
    log_success "System updated successfully"
}

# Install curl
install_curl() {
    if command_exists curl; then
        log_warning "curl is already installed"
        return
    fi
    log_info "Installing curl..."
    sudo apt install curl -y
    log_success "curl installed successfully"
}

# Install git and git-flow
install_git() {
    if command_exists git; then
        log_warning "git is already installed"
    else
        log_info "Installing git..."
        sudo apt install git -y
        log_success "git installed successfully"
    fi
    
    if command_exists git-flow; then
        log_warning "git-flow is already installed"
    else
        log_info "Installing git-flow..."
        sudo apt install git-flow -y
        log_success "git-flow installed successfully"
    fi
    
    # Configure git
    echo ""
    read -p "Do you want to configure git now? (y/n): " configure_git
    if [[ $configure_git =~ ^[Yy]$ ]]; then
        read -p "Enter your git username: " git_username
        read -p "Enter your git email: " git_email
        git config --global user.name "$git_username"
        git config --global user.email "$git_email"
        log_success "Git configured successfully"
    fi
}

# Install Zsh and Oh My Zsh
install_zsh() {
    if command_exists zsh; then
        log_warning "zsh is already installed"
    else
        log_info "Installing zsh..."
        sudo apt install zsh -y
        log_success "zsh installed successfully"
    fi
    
    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_warning "Oh My Zsh is already installed"
    else
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh installed successfully"
    fi
}

# Install Terminator
install_terminator() {
    if package_installed terminator; then
        log_warning "Terminator is already installed"
        return
    fi
    log_info "Installing Terminator..."
    sudo apt-get install terminator -y
    log_success "Terminator installed successfully"
}

# Install Node.js with nvm
install_nodejs() {
    if command_exists nvm; then
        log_warning "nvm is already installed"
    else
        log_info "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        log_success "nvm installed successfully"
    fi
    
    if command_exists node; then
        log_warning "Node.js is already installed"
    else
        log_info "Installing latest LTS Node.js..."
        source ~/.bashrc
        nvm install --lts
        nvm use --lts
        log_success "Node.js installed successfully"
    fi
}

# Install PM2
install_pm2() {
    if command_exists pm2; then
        log_warning "PM2 is already installed"
        return
    fi
    log_info "Installing PM2..."
    npm install pm2 -g
    log_success "PM2 installed successfully"
}

# Install Docker
install_docker() {
    if command_exists docker; then
        log_warning "Docker is already installed"
    else
        log_info "Installing Docker..."
        # Add Docker's official GPG key
        sudo apt-get update
        sudo apt-get install ca-certificates curl gnupg -y
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        
        # Add the repository to Apt sources
        echo \
          "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
          \"$(. /etc/os-release && echo \"$VERSION_CODENAME\")\" stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
        
        # Add user to docker group
        sudo groupadd docker 2>/dev/null || true
        sudo usermod -aG docker $USER
        
        log_success "Docker installed successfully"
        log_warning "Please log out and log back in for docker group changes to take effect"
    fi
}

# Install Go
install_go() {
    if command_exists go; then
        log_warning "Go is already installed"
        return
    fi
    
    log_info "Getting latest Go version..."
    GO_VERSION=$(curl -s https://api.github.com/repos/golang/go/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
    GO_VERSION=${GO_VERSION#go}
    
    log_info "Installing Go $GO_VERSION..."
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    rm go${GO_VERSION}.linux-amd64.tar.gz
    
    # Add to PATH
    if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
        echo 'export GOPATH=$HOME/go' >> ~/.bashrc
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
    fi
    
    log_success "Go installed successfully"
}

# Install VS Code
install_vscode() {
    if command_exists code; then
        log_warning "VS Code is already installed"
        return
    fi
    log_info "Installing VS Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install code -y
    log_success "VS Code installed successfully"
}

# Install Postman
install_postman() {
    if snap_installed postman; then
        log_warning "Postman is already installed"
        return
    fi
    log_info "Installing Postman..."
    sudo snap install postman
    log_success "Postman installed successfully"
}

# Install MongoDB Compass
install_mongodb_compass() {
    if command_exists mongodb-compass; then
        log_warning "MongoDB Compass is already installed"
        return
    fi
    log_info "Installing MongoDB Compass..."
    wget https://downloads.mongodb.com/compass/mongodb-compass_1.40.4_amd64.deb
    sudo dpkg -i mongodb-compass_1.40.4_amd64.deb
    sudo apt-get install -f -y
    rm mongodb-compass_1.40.4_amd64.deb
    log_success "MongoDB Compass installed successfully"
}

# Install Redis Insight
install_redis_insight() {
    if snap_installed redis-insight; then
        log_warning "Redis Insight is already installed"
        return
    fi
    log_info "Installing Redis Insight..."
    sudo snap install redis-insight
    log_success "Redis Insight installed successfully"
}

# Install DBeaver
install_dbeaver() {
    if snap_installed dbeaver-ce; then
        log_warning "DBeaver is already installed"
        return
    fi
    log_info "Installing DBeaver..."
    sudo snap install dbeaver-ce
    log_success "DBeaver installed successfully"
}

# Install Flameshot
install_flameshot() {
    if package_installed flameshot; then
        log_warning "Flameshot is already installed"
        return
    fi
    log_info "Installing Flameshot..."
    sudo apt install flameshot -y
    log_success "Flameshot installed successfully"
}

# Install OBS Studio
install_obs() {
    if package_installed obs-studio; then
        log_warning "OBS Studio is already installed"
        return
    fi
    log_info "Installing OBS Studio..."
    sudo apt install obs-studio -y
    log_success "OBS Studio installed successfully"
}

# Install FileZilla
install_filezilla() {
    if package_installed filezilla; then
        log_warning "FileZilla is already installed"
        return
    fi
    log_info "Installing FileZilla..."
    sudo apt install filezilla -y
    log_success "FileZilla installed successfully"
}

# Install Google Chrome
install_chrome() {
    if command_exists google-chrome; then
        log_warning "Google Chrome is already installed"
        return
    fi
    log_info "Installing Google Chrome..."
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    sudo apt update
    sudo apt install google-chrome-stable -y
    log_success "Google Chrome installed successfully"
}

# Install XDM
install_xdm() {
    if command_exists xdman; then
        log_warning "XDM is already installed"
        return
    fi
    log_info "Installing XDM (Xtreme Download Manager)..."
    wget https://github.com/subhra74/xdm/releases/download/7.2.11/xdm-setup-7.2.11.tar.xz
    tar -xf xdm-setup-7.2.11.tar.xz
    sudo ./install.sh
    rm -rf xdm-setup-7.2.11.tar.xz install.sh
    log_success "XDM installed successfully"
}

# Interactive menu system
show_menu() {
    clear
    log_header "Ubuntu Post-Installation Setup Script"
    echo ""
    echo "Select category to install applications:"
    echo ""
    echo "1)  System Setup & Updates (curl, git, git-flow)"
    echo "2)  Shell & Terminal Tools (Zsh, Oh My Zsh, Terminator)"
    echo "3)  Development Tools (Node.js/nvm, PM2, Docker, Go, VS Code, Postman, XDM)"
    echo "4)  Database & Data Management (MongoDB Compass, Redis Insight, DBeaver)"
    echo "5)  Media & Recording Tools (Flameshot, OBS Studio)"
    echo "6)  File Transfer & Management (FileZilla)"
    echo "7)  Web Browsers (Google Chrome)"
    echo "8)  Install All Applications"
    echo "9)  Exit"
    echo ""
}

system_setup_menu() {
    clear
    log_header "System Setup & Updates"
    echo ""
    echo "Select items to install:"
    echo ""
    echo "1) Update System"
    echo "2) Install curl"
    echo "3) Install git and git-flow"
    echo "4) Install All"
    echo "5) Back to Main Menu"
    echo ""
    
    read -p "Enter your choice [1-5]: " choice
    case $choice in
        1) update_system ;;
        2) install_curl ;;
        3) install_git ;;
        4) 
            update_system
            install_curl
            install_git
            ;;
        5) return ;;
        *) log_error "Invalid option" ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
}

shell_terminal_menu() {
    clear
    log_header "Shell & Terminal Tools"
    echo ""
    echo "Select items to install:"
    echo ""
    echo "1) Install Zsh & Oh My Zsh"
    echo "2) Install Terminator"
    echo "3) Install All"
    echo "4) Back to Main Menu"
    echo ""
    
    read -p "Enter your choice [1-4]: " choice
    case $choice in
        1) install_zsh ;;
        2) install_terminator ;;
        3) 
            install_zsh
            install_terminator
            ;;
        4) return ;;
        *) log_error "Invalid option" ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
}

development_menu() {
    clear
    log_header "Development Tools"
    echo ""
    echo "Select items to install:"
    echo ""
    echo "1) Install Node.js with nvm"
    echo "2) Install PM2"
    echo "3) Install Docker"
    echo "4) Install Go"
    echo "5) Install VS Code"
    echo "6) Install Postman"
    echo "7) Install XDM"
    echo "8) Install All"
    echo "9) Back to Main Menu"
    echo ""
    
    read -p "Enter your choice [1-9]: " choice
    case $choice in
        1) install_nodejs ;;
        2) install_pm2 ;;
        3) install_docker ;;
        4) install_go ;;
        5) install_vscode ;;
        6) install_postman ;;
        7) install_xdm ;;
        8) 
            install_nodejs
            install_pm2
            install_docker
            install_go
            install_vscode
            install_postman
            install_xdm
            ;;
        9) return ;;
        *) log_error "Invalid option" ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
}

database_menu() {
    clear
    log_header "Database & Data Management"
    echo ""
    echo "Select items to install:"
    echo ""
    echo "1) Install MongoDB Compass"
    echo "2) Install Redis Insight"
    echo "3) Install DBeaver"
    echo "4) Install All"
    echo "5) Back to Main Menu"
    echo ""
    
    read -p "Enter your choice [1-5]: " choice
    case $choice in
        1) install_mongodb_compass ;;
        2) install_redis_insight ;;
        3) install_dbeaver ;;
        4) 
            install_mongodb_compass
            install_redis_insight
            install_dbeaver
            ;;
        5) return ;;
        *) log_error "Invalid option" ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
}

media_menu() {
    clear
    log_header "Media & Recording Tools"
    echo ""
    echo "Select items to install:"
    echo ""
    echo "1) Install Flameshot"
    echo "2) Install OBS Studio"
    echo "3) Install All"
    echo "4) Back to Main Menu"
    echo ""
    
    read -p "Enter your choice [1-4]: " choice
    case $choice in
        1) install_flameshot ;;
        2) install_obs ;;
        3) 
            install_flameshot
            install_obs
            ;;
        4) return ;;
        *) log_error "Invalid option" ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
}

file_transfer_menu() {
    clear
    log_header "File Transfer & Management"
    echo ""
    echo "Select items to install:"
    echo ""
    echo "1) Install FileZilla"
    echo "2) Back to Main Menu"
    echo ""
    
    read -p "Enter your choice [1-2]: " choice
    case $choice in
        1) install_filezilla ;;
        2) return ;;
        *) log_error "Invalid option" ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
}

browser_menu() {
    clear
    log_header "Web Browsers"
    echo ""
    echo "Select items to install:"
    echo ""
    echo "1) Install Google Chrome"
    echo "2) Back to Main Menu"
    echo ""
    
    read -p "Enter your choice [1-2]: " choice
    case $choice in
        1) install_chrome ;;
        2) return ;;
        *) log_error "Invalid option" ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
}

install_all() {
    clear
    log_header "Installing All Applications"
    echo ""
    log_info "This will install all available applications. This may take a while..."
    echo ""
    read -p "Are you sure you want to continue? (y/n): " confirm
    
    if [[ $confirm =~ ^[Yy]$ ]]; then
        # System Setup
        update_system
        install_curl
        install_git
        
        # Shell & Terminal
        install_zsh
        install_terminator
        
        # Development Tools
        install_nodejs
        install_pm2
        install_docker
        install_go
        install_vscode
        install_postman
        install_xdm
        
        # Database Tools
        install_mongodb_compass
        install_redis_insight
        install_dbeaver
        
        # Media Tools
        install_flameshot
        install_obs
        
        # File Transfer
        install_filezilla
        
        # Browsers
        install_chrome
        
        log_success "All applications have been installed!"
    else
        log_info "Installation cancelled"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Main script loop
main() {
    while true; do
        show_menu
        read -p "Enter your choice [1-9]: " choice
        
        case $choice in
            1) system_setup_menu ;;
            2) shell_terminal_menu ;;
            3) development_menu ;;
            4) database_menu ;;
            5) media_menu ;;
            6) file_transfer_menu ;;
            7) browser_menu ;;
            8) install_all ;;
            9) 
                log_info "Thank you for using the Ubuntu Post-Installation Setup Script!"
                exit 0
                ;;
            *) 
                log_error "Invalid option. Please try again."
                read -p "Press Enter to continue..."
                ;;
        esac
    done
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    log_error "This script should not be run as root"
    exit 1
fi

# Start the main script
main