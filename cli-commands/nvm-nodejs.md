# NVM and Node.js CLI Commands

## NVM (Node Version Manager) Commands
```bash
# Install NVM (run installation script first)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc

# List available Node versions
nvm list-remote
nvm ls-remote
nvm ls-remote --lts        # Only LTS versions

# Install Node versions
nvm install node           # Install latest version
nvm install --lts          # Install latest LTS
nvm install 18.17.0        # Install specific version
nvm install 18             # Install latest 18.x version

# List installed versions
nvm list
nvm ls

# Use specific Node version
nvm use node               # Use latest installed
nvm use --lts              # Use latest LTS installed
nvm use 18.17.0            # Use specific version
nvm use 18                 # Use latest 18.x installed

# Set default Node version
nvm alias default node    # Set latest as default
nvm alias default 18.17.0 # Set specific version as default
nvm alias default --lts   # Set latest LTS as default

# Uninstall Node versions
nvm uninstall 16.14.0
```

## Node.js and NPM Commands
```bash
# Check versions
node --version
node -v
npm --version
npm -v

# Run Node.js
node                       # Start REPL
node script.js             # Run script
node -e "console.log('Hello')"  # Execute code

# Initialize project
npm init
npm init -y                # Skip prompts

# Install packages
npm install <package>
npm install <package>@<version>
npm install <package> --save-dev
npm install -g <package>   # Global installation

# Package management
npm list                   # List installed packages
npm list -g                # List global packages
npm list --depth=0         # Top-level packages only
npm outdated               # Check for updates
npm update                 # Update packages
npm update -g              # Update global packages

# Remove packages
npm uninstall <package>
npm uninstall -g <package>
npm uninstall --save-dev <package>

# Scripts
npm run <script-name>
npm start                  # Run start script
npm test                   # Run test script
npm run build              # Run build script
```

## Package.json Scripts
```json
{
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js",
    "test": "jest",
    "build": "webpack --mode production",
    "lint": "eslint src/",
    "format": "prettier --write src/"
  }
}
```

## NPX Commands
```bash
# Run packages without installing
npx <package>
npx create-react-app my-app
npx @angular/cli new my-app
npx express-generator my-app

# Run local packages
npx eslint .
npx prettier --write .
npx jest
```

## Yarn Commands (Alternative to NPM)
```bash
# Install Yarn
npm install -g yarn

# Project management
yarn init
yarn init -y

# Package management
yarn add <package>
yarn add <package>@<version>
yarn add --dev <package>
yarn global add <package>

# Remove packages
yarn remove <package>
yarn global remove <package>

# Run scripts
yarn <script-name>
yarn start
yarn test
yarn build

# Upgrade packages
yarn upgrade
yarn upgrade <package>
```

## Node.js Project Management
```bash
# Create .nvmrc file for project
echo "18.17.0" > .nvmrc

# Auto-switch Node version (add to .zshrc)
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
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
```

## Debugging Node.js
```bash
# Debug mode
node --inspect script.js
node --inspect-brk script.js  # Break on first line

# Debug with Chrome DevTools
node --inspect=9229 script.js

# Enable source maps
node --enable-source-maps script.js

# Memory and performance
node --max-old-space-size=4096 script.js
node --trace-gc script.js
```

## Environment and Configuration
```bash
# Set NODE_ENV
export NODE_ENV=production
export NODE_ENV=development

# Use .env files (with dotenv package)
node -r dotenv/config script.js

# Check Node.js configuration
node -p "process.versions"
node -p "process.platform"
node -p "process.arch"
```

## Useful Aliases
```bash
# Add to .zshrc or .bashrc
alias ni='npm install'
alias nig='npm install -g'
alias nid='npm install --save-dev'
alias nrun='npm run'
alias nstart='npm start'
alias ntest='npm test'
alias nbuild='npm run build'

# NVM aliases
alias nvmls='nvm list'
alias nvmuse='nvm use'
alias nvmdefault='nvm alias default'
```

## Package.json Useful Scripts
```bash
# Development server with auto-restart
npm install -g nodemon
# Add to package.json: "dev": "nodemon server.js"

# Environment-specific scripts
# "start:dev": "NODE_ENV=development node server.js"
# "start:prod": "NODE_ENV=production node server.js"

# Clean and install
# "clean": "rm -rf node_modules package-lock.json && npm install"
# "fresh": "npm run clean && npm install"
```