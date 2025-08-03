# APT CLI Commands

## Basic Package Management
```bash
# Update package lists
sudo apt update

# Upgrade packages
sudo apt upgrade
sudo apt full-upgrade    # More thorough upgrade

# Update and upgrade in one command
sudo apt update && sudo apt upgrade

# Install packages
sudo apt install package-name
sudo apt install package1 package2 package3

# Install specific version
sudo apt install package-name=version

# Install .deb file
sudo apt install ./package.deb
sudo dpkg -i package.deb  # Alternative method
```

## Package Information and Search
```bash
# Search for packages
apt search search-term
apt search "exact phrase"

# Show package information
apt show package-name
apt info package-name

# List installed packages
apt list --installed
apt list --installed | grep package-name

# List available packages
apt list
apt list --upgradable

# Check if package is installed
dpkg -l | grep package-name
```

## Package Removal
```bash
# Remove package (keep config files)
sudo apt remove package-name

# Remove package and config files
sudo apt purge package-name

# Remove package and unused dependencies
sudo apt autoremove package-name

# Clean up orphaned packages
sudo apt autoremove

# Remove old package cache
sudo apt autoclean
sudo apt clean  # Remove all cached packages
```

## Repository Management
```bash
# Add repository
sudo add-apt-repository ppa:repository/name
sudo add-apt-repository "deb http://repository.url"

# Remove repository
sudo add-apt-repository --remove ppa:repository/name

# Edit sources list
sudo nano /etc/apt/sources.list
sudo nano /etc/apt/sources.list.d/

# Add GPG key
wget -qO - https://example.com/key.gpg | sudo apt-key add -
curl -fsSL https://example.com/key.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/example.gpg
```

## Advanced Package Operations
```bash
# Install without recommendations
sudo apt install --no-install-recommends package-name

# Install without prompts
sudo apt install -y package-name

# Simulate installation (dry run)
apt install --dry-run package-name

# Download package without installing
apt download package-name

# Check package dependencies
apt depends package-name
apt rdepends package-name  # Reverse dependencies

# Hold package (prevent updates)
sudo apt-mark hold package-name
sudo apt-mark unhold package-name
sudo apt-mark showhold  # Show held packages
```

## System Maintenance
```bash
# Fix broken packages
sudo apt --fix-broken install
sudo apt -f install

# Fix missing dependencies
sudo apt install --fix-missing

# Reconfigure package
sudo dpkg-reconfigure package-name

# Check for security updates
sudo unattended-upgrades --dry-run

# Update initramfs
sudo update-initramfs -u

# Update GRUB
sudo update-grub
```

## Package Cache Management
```bash
# Check cache size
du -sh /var/cache/apt/archives/

# Clean package cache
sudo apt clean        # Remove all cached packages
sudo apt autoclean    # Remove only outdated cached packages

# Remove partial packages
sudo apt autoclean
```

## Useful Information Commands
```bash
# Show APT configuration
apt config dump

# Show APT history
cat /var/log/apt/history.log
zcat /var/log/apt/history.log.*.gz

# Show package files
dpkg -L package-name

# Find which package owns a file
dpkg -S /path/to/file

# Check package status
dpkg -s package-name

# List package contents (for .deb files)
dpkg -c package.deb
```

## Security and Updates
```bash
# Install security updates only
sudo apt upgrade -s | grep -i security

# Check for available security updates
/usr/lib/update-notifier/apt-check --human-readable

# Automatic security updates configuration
sudo dpkg-reconfigure unattended-upgrades

# Show package changelogs
apt changelog package-name
```

## Package Building and Source
```bash
# Get source code
apt source package-name

# Install build dependencies
sudo apt build-dep package-name

# Build package from source
apt source package-name
cd package-directory
dpkg-buildpackage -b

# Check package signatures
apt-key list
apt-key fingerprint
```

## Useful Shell Functions
```bash
# Add to .zshrc or .bashrc

# Quick package search and install
search-install() {
    apt search "$1"
    read -p "Install package? (y/n): " -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo apt install "$1"
    fi
}

# Update and upgrade system
update-system() {
    echo "Updating package lists..."
    sudo apt update
    echo "Upgrading packages..."
    sudo apt upgrade
    echo "Cleaning up..."
    sudo apt autoremove
    sudo apt autoclean
}

# Show package information with dependencies
pkg-info() {
    apt show "$1"
    echo -e "\n--- Dependencies ---"
    apt depends "$1"
}

# List large packages
large-packages() {
    dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | tail -20
}

# Check which package provides a command
which-package() {
    dpkg -S $(which "$1") 2>/dev/null || echo "Command not found or not from a package"
}

# Count installed packages
count-packages() {
    echo "Installed packages: $(dpkg -l | grep ^ii | wc -l)"
    echo "Available packages: $(apt list 2>/dev/null | wc -l)"
}
```

## APT Configuration
```bash
# APT configuration file
sudo nano /etc/apt/apt.conf.d/99custom

# Common configurations:
# APT::Get::Assume-Yes "true";  # Auto-confirm
# APT::Install-Recommends "false";  # Don't install recommendations
# APT::Install-Suggests "false";    # Don't install suggestions
# Acquire::Retries "3";  # Retry failed downloads
```

## Repository Examples
```bash
# Add popular repositories

# Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
```

## Troubleshooting
```bash
# Fix "unable to locate package" error
sudo apt update

# Fix GPG key errors
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys KEY_ID

# Fix dependency issues
sudo apt --fix-broken install

# Clear APT cache if corrupted
sudo rm -rf /var/lib/apt/lists/*
sudo apt update

# Reset sources list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
sudo software-properties-gtk  # GUI to reset

# Fix DPKG lock
sudo killall apt apt-get
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*
sudo dpkg --configure -a
```

## Useful Aliases
```bash
# Add to .zshrc or .bashrc
alias aptu='sudo apt update'
alias aptg='sudo apt upgrade'
alias apti='sudo apt install'
alias aptr='sudo apt remove'
alias apts='apt search'
alias aptsh='apt show'
alias aptl='apt list --installed'
alias aptc='sudo apt autoclean && sudo apt autoremove'
alias update-sys='sudo apt update && sudo apt upgrade && sudo apt autoremove'
```

## Monitoring and Logs
```bash
# APT history
cat /var/log/apt/history.log
grep " install " /var/log/apt/history.log

# APT term log
cat /var/log/apt/term.log

# Check for broken packages
sudo apt check

# Verify package integrity
sudo debsums -c
```

## Backup and Restore
```bash
# Backup installed packages list
dpkg --get-selections > packages.list

# Restore packages on new system
sudo dpkg --set-selections < packages.list
sudo apt dselect-upgrade

# Backup APT sources
sudo cp -R /etc/apt/sources.list* ~/apt-backup/

# Backup APT keys
sudo cp -R /etc/apt/trusted.gpg* ~/apt-backup/
```