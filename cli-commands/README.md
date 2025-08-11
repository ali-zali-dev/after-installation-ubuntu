# CLI Commands Documentation

This folder contains comprehensive CLI command references for all the tools mentioned in the main README. Each file provides practical command examples, common use cases, and useful tips for daily development work.

## 📁 Available Command References

### System & Development Tools
- **[APT](apt.md)** - Package management, repositories, system maintenance
- **[Git](git.md)** - Version control, branching, collaboration workflows
- **[Curl](curl.md)** - HTTP requests, API testing, file transfers
- **[Docker](docker.md)** - Container management, Docker Compose, registry operations

### Programming Languages & Runtime
- **[Node.js & NVM](nvm-nodejs.md)** - Node version management, npm, package.json scripts
- **[PM2](pm2.md)** - Process management, clustering, monitoring
- **[Go](go.md)** - Go development, modules, building, testing

### Virtualization
- **[VirtualBox](virtualbox.md)** - VM management, snapshots, networking, guest additions

### Databases
- **[MongoDB](mongodb.md)** - Database operations, aggregation, indexing
- **[PostgreSQL](postgresql.md)** - SQL operations, backup/restore, user management
- **[Redis](redis.md)** - Key-value operations, data structures, pub/sub

### Media & Utilities
- **[Flameshot](flameshot.md)** - Screenshot automation, configuration, scripting
- **[OBS Studio](obs-studio.md)** - Recording automation, streaming setup
- **[FileZilla](filezilla.md)** - FTP operations (plus CLI alternatives like sftp, rsync)

### System Configuration
- **[GNOME Settings](gnome-settings.md)** - Desktop customization, extensions, theming

## 🚀 Quick Navigation

### Most Common Commands
```bash
# System maintenance
sudo apt update && sudo apt upgrade
git status && git pull
docker ps && docker images

# Development workflow
nvm use && npm install
pm2 list && pm2 logs
go mod tidy && go test ./...

# Virtualization
VBoxManage list vms
VBoxManage startvm "VM_Name"

# Database operations
mongosh --eval "show dbs"
psql -l
redis-cli ping

# Quick screenshot
flameshot gui
```

### Essential Aliases to Add
```bash
# Add these to your .zshrc or .bashrc
alias ll='ls -la'
alias aptu='sudo apt update'
alias gs='git status'
alias gp='git pull'
alias dc='docker compose'
alias pm='pm2'
alias vbm='VBoxManage'
alias vblist='VBoxManage list vms'
alias vbstart='VBoxManage startvm'
alias screenshot='flameshot gui'
```

## 💡 Tips for Using These References

1. **Search within files**: Use `Ctrl+F` to quickly find specific commands
2. **Copy-paste ready**: All commands are formatted for direct terminal use
3. **Context provided**: Each command includes explanations and use cases
4. **Progressive difficulty**: Commands go from basic to advanced
5. **Cross-references**: Related commands are grouped together

## 🔧 Setting Up Your Environment

Before using these commands, ensure you have the tools installed as described in the main README:

1. Run the installation script: `./install.sh`
2. Or manually install tools using the commands in each reference
3. Set up aliases and functions from the provided examples
4. Configure your shell with the recommended settings

## 📚 Additional Resources

- Main installation guide: `../README.md`
- Docker services: `../docker/`
- Each tool's official documentation for deeper understanding

## 🤝 Contributing

Found a useful command not listed here? Feel free to add it to the appropriate file. Keep the format consistent with:
- Clear section headers
- Practical examples
- Brief explanations
- Common use cases

---

*These references are designed to be practical guides for daily development work. Bookmark this folder and refer to it whenever you need quick command examples!*