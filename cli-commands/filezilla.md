# FileZilla CLI Commands

## Installation
```bash
# Install FileZilla
sudo apt install filezilla

# Verify installation
filezilla --version
```

## Basic CLI Operations
```bash
# Launch FileZilla GUI
filezilla

# Launch with specific site (if configured)
filezilla -s "site_name"

# Launch with logfile
filezilla -l /path/to/logfile.log

# Show help
filezilla --help
```

## Command Line FTP Alternatives
Since FileZilla is primarily a GUI application, here are CLI alternatives for FTP operations:

### Using sftp (Secure FTP)
```bash
# Connect to SFTP server
sftp user@hostname
sftp -P 2222 user@hostname  # Custom port

# SFTP commands (interactive)
ls                    # List remote directory
lls                   # List local directory
pwd                   # Show remote directory
lpwd                  # Show local directory
cd remote_dir         # Change remote directory
lcd local_dir         # Change local directory
get remote_file       # Download file
put local_file        # Upload file
mget *.txt           # Download multiple files
mput *.txt           # Upload multiple files
mkdir dirname        # Create remote directory
rmdir dirname        # Remove remote directory
rm filename          # Delete remote file
chmod 755 filename   # Change file permissions
quit                 # Exit
```

### Using rsync (Recommended for syncing)
```bash
# Sync local to remote
rsync -avz /local/path/ user@hostname:/remote/path/

# Sync remote to local
rsync -avz user@hostname:/remote/path/ /local/path/

# Sync with SSH key
rsync -avz -e "ssh -i ~/.ssh/keyfile" /local/path/ user@hostname:/remote/path/

# Sync with progress and exclude patterns
rsync -avz --progress --exclude='*.tmp' /local/path/ user@hostname:/remote/path/

# Dry run (test without actual transfer)
rsync -avz --dry-run /local/path/ user@hostname:/remote/path/
```

### Using scp (Secure Copy)
```bash
# Copy file to remote server
scp local_file user@hostname:/remote/path/

# Copy file from remote server
scp user@hostname:/remote/path/file local_path/

# Copy directory recursively
scp -r local_directory user@hostname:/remote/path/

# Copy with custom SSH port
scp -P 2222 local_file user@hostname:/remote/path/

# Copy with SSH key
scp -i ~/.ssh/keyfile local_file user@hostname:/remote/path/

# Copy multiple files
scp file1 file2 file3 user@hostname:/remote/path/
```

### Using ftp (Traditional FTP)
```bash
# Connect to FTP server
ftp hostname
ftp -p hostname  # Passive mode

# FTP commands (interactive)
open hostname    # Connect to server
user username    # Login
binary          # Set binary mode
ascii           # Set ASCII mode
ls              # List files
cd directory    # Change directory
lcd directory   # Change local directory
get filename    # Download file
put filename    # Upload file
mget *.txt      # Download multiple files
mput *.txt      # Upload multiple files
delete filename # Delete remote file
mkdir dirname   # Create directory
rmdir dirname   # Remove directory
quit            # Exit
```

## Automated File Transfer Scripts
```bash
# SFTP batch script
#!/bin/bash
# sftp-upload.sh

REMOTE_HOST="example.com"
REMOTE_USER="username"
REMOTE_PATH="/remote/path"
LOCAL_PATH="/local/path"

# Create SFTP batch file
cat > /tmp/sftp_commands << EOF
cd $REMOTE_PATH
lcd $LOCAL_PATH
put *
quit
EOF

# Execute SFTP batch
sftp -b /tmp/sftp_commands $REMOTE_USER@$REMOTE_HOST

# Clean up
rm /tmp/sftp_commands
```

## Configuration Files
```bash
# SSH config for easier connections
# ~/.ssh/config
Host myserver
    HostName example.com
    User myuser
    Port 22
    IdentityFile ~/.ssh/mykey

# Usage after config
sftp myserver
scp file myserver:/path/
```

## Useful Functions
```bash
# Add to .zshrc or .bashrc

# Quick file upload
upload() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: upload <file> <server>"
        return 1
    fi
    scp "$1" "$2":/tmp/
}

# Quick file download
download() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: download <server> <remote_file>"
        return 1
    fi
    scp "$1":"$2" ./
}

# Sync directory to remote
sync-up() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: sync-up <local_dir> <server:remote_dir>"
        return 1
    fi
    rsync -avz --progress "$1"/ "$2"/
}

# Sync directory from remote
sync-down() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: sync-down <server:remote_dir> <local_dir>"
        return 1
    fi
    rsync -avz --progress "$1"/ "$2"/
}
```

## FileZilla Site Manager (Backup/Restore)
```bash
# FileZilla sites are stored in XML format
# Location: ~/.config/filezilla/sitemanager.xml

# Backup FileZilla sites
cp ~/.config/filezilla/sitemanager.xml ~/filezilla-sites-backup.xml

# Restore FileZilla sites
cp ~/filezilla-sites-backup.xml ~/.config/filezilla/sitemanager.xml
```

## Common Transfer Patterns
```bash
# Website deployment
deploy-website() {
    local site_dir="/var/www/mysite"
    local remote="user@webserver.com"
    
    rsync -avz --delete \
          --exclude='.git' \
          --exclude='node_modules' \
          --exclude='*.log' \
          "$site_dir"/ "$remote:/var/www/html/"
}

# Backup download
backup-download() {
    local remote="user@server.com"
    local backup_dir="~/backups/$(date +%Y%m%d)"
    
    mkdir -p "$backup_dir"
    rsync -avz "$remote:/path/to/backup/" "$backup_dir/"
}

# Photo upload
upload-photos() {
    local photo_dir="$1"
    local remote="user@photoserver.com"
    
    if [ -d "$photo_dir" ]; then
        rsync -avz --progress \
              --include='*.jpg' \
              --include='*.jpeg' \
              --include='*.png' \
              --exclude='*' \
              "$photo_dir"/ "$remote:/photos/"
    fi
}
```

## Aliases
```bash
# Add to .zshrc or .bashrc
alias fz='filezilla'
alias ftp-connect='sftp'
alias quick-upload='scp'
alias quick-download='scp'
alias sync-files='rsync -avz --progress'
```