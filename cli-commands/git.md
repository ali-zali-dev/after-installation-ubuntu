# Git CLI Commands

## Basic Configuration
```bash
# Set global configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main

# View configuration
git config --list
git config --global --list
```

## Repository Management
```bash
# Initialize repository
git init

# Clone repository
git clone <repository-url>
git clone <repository-url> <directory-name>

# Add remote
git remote add origin <repository-url>
git remote -v
```

## Working with Changes
```bash
# Check status
git status
git status -s  # Short format

# Add files
git add <file>
git add .
git add -A
git add -u  # Update tracked files only

# Commit changes
git commit -m "Commit message"
git commit -am "Add and commit tracked files"
git commit --amend  # Amend last commit
```

## Branching
```bash
# List branches
git branch
git branch -a  # All branches
git branch -r  # Remote branches

# Create and switch branches
git checkout -b <branch-name>
git switch -c <branch-name>  # New syntax

# Switch branches
git checkout <branch-name>
git switch <branch-name>  # New syntax

# Delete branches
git branch -d <branch-name>
git branch -D <branch-name>  # Force delete
```

## Git Flow Commands
```bash
# Initialize git flow
git flow init

# Feature branches
git flow feature start <feature-name>
git flow feature finish <feature-name>
git flow feature publish <feature-name>

# Release branches
git flow release start <version>
git flow release finish <version>

# Hotfix branches
git flow hotfix start <version>
git flow hotfix finish <version>
```

## Remote Operations
```bash
# Fetch and pull
git fetch
git fetch origin
git pull
git pull origin <branch-name>

# Push changes
git push
git push origin <branch-name>
git push -u origin <branch-name>  # Set upstream
git push --force-with-lease  # Safe force push
```

## Log and History
```bash
# View commit history
git log
git log --oneline
git log --graph
git log --graph --oneline --all

# Show specific commit
git show <commit-hash>

# View file history
git log --follow <file>
```

## Stashing
```bash
# Stash changes
git stash
git stash save "Message"
git stash -u  # Include untracked files

# List and apply stashes
git stash list
git stash pop
git stash apply
git stash drop
```

## Undoing Changes
```bash
# Discard working directory changes
git checkout -- <file>
git restore <file>  # New syntax

# Unstage files
git reset HEAD <file>
git restore --staged <file>  # New syntax

# Reset commits
git reset --soft HEAD~1  # Keep changes staged
git reset --mixed HEAD~1  # Keep changes unstaged
git reset --hard HEAD~1  # Discard changes

# Revert commits
git revert <commit-hash>
```

## Useful Aliases
```bash
# Set up useful aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
```