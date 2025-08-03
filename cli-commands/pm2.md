# PM2 CLI Commands

## Installation and Setup
```bash
# Install PM2 globally
npm install pm2 -g

# Update PM2
npm update pm2 -g

# PM2 version
pm2 --version
```

## Basic Process Management
```bash
# Start applications
pm2 start app.js
pm2 start app.js --name "my-app"
pm2 start npm -- start           # Start npm script
pm2 start "npm run dev" --name dev-server

# List processes
pm2 list
pm2 ls
pm2 status

# Stop processes
pm2 stop <app-name|id>
pm2 stop all

# Restart processes
pm2 restart <app-name|id>
pm2 restart all

# Delete processes
pm2 delete <app-name|id>
pm2 delete all
```

## Process Monitoring
```bash
# Monitor processes in real-time
pm2 monit

# Show process information
pm2 show <app-name|id>
pm2 info <app-name|id>

# View logs
pm2 logs                     # All processes
pm2 logs <app-name|id>       # Specific process
pm2 logs --lines 100        # Last 100 lines
pm2 flush                    # Clear logs
```

## Configuration File (ecosystem.config.js)
```javascript
module.exports = {
  apps: [{
    name: 'api-server',
    script: 'server.js',
    instances: 4,
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'development',
      PORT: 3000
    },
    env_production: {
      NODE_ENV: 'production',
      PORT: 8080
    },
    log_file: './logs/combined.log',
    out_file: './logs/out.log',
    error_file: './logs/error.log',
    log_date_format: 'YYYY-MM-DD HH:mm Z'
  }]
};
```

## Using Configuration Files
```bash
# Start with config file
pm2 start ecosystem.config.js
pm2 start ecosystem.config.js --env production

# Generate ecosystem file
pm2 ecosystem

# Reload configuration
pm2 reload ecosystem.config.js
```

## Cluster Mode
```bash
# Start in cluster mode
pm2 start app.js -i max       # Use all CPU cores
pm2 start app.js -i 4         # Use 4 instances
pm2 start app.js -i 0         # Auto detect CPU cores

# Scale processes
pm2 scale <app-name> 5        # Scale to 5 instances
pm2 scale <app-name> +2       # Add 2 more instances
```

## Environment Management
```bash
# Start with environment variables
pm2 start app.js --env production
pm2 restart <app-name> --env production

# Update environment variables
pm2 restart <app-name> --update-env
```

## Process Actions
```bash
# Reload (zero-downtime restart)
pm2 reload <app-name|id>
pm2 reload all

# Graceful reload
pm2 gracefulReload <app-name|id>

# Send signals
pm2 sendSignal SIGUSR2 <app-name|id>

# Reset counters
pm2 reset <app-name|id>
```

## Startup and Auto-restart
```bash
# Generate startup script
pm2 startup

# Save current process list
pm2 save

# Restore saved processes
pm2 resurrect

# Disable startup
pm2 unstartup

# Update startup script
pm2 startup --update
```

## Log Management
```bash
# Real-time logs
pm2 logs --raw              # Raw format
pm2 logs --json             # JSON format
pm2 logs --timestamp        # With timestamps

# Log rotation (install module first)
pm2 install pm2-logrotate

# Configure log rotation
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 30
pm2 set pm2-logrotate:dateFormat YYYY-MM-DD_HH-mm-ss
```

## Memory and CPU Monitoring
```bash
# Memory usage
pm2 list --format table

# CPU and memory limits
pm2 start app.js --max-memory-restart 100M
pm2 start app.js --max-restarts 5

# Watch for file changes
pm2 start app.js --watch
pm2 start app.js --watch --ignore-watch="node_modules"
```

## Process Maintenance
```bash
# Update PM2
pm2 update

# Kill PM2 daemon
pm2 kill

# Dump processes
pm2 dump

# Prettyfy process list
pm2 prettylist

# Web interface
pm2 web
```

## Useful PM2 Ecosystem Examples
```javascript
// Development environment
module.exports = {
  apps: [{
    name: 'dev-server',
    script: 'server.js',
    watch: true,
    ignore_watch: ['node_modules', 'logs'],
    env: {
      NODE_ENV: 'development',
      PORT: 3000
    }
  }]
};

// Production environment
module.exports = {
  apps: [{
    name: 'prod-api',
    script: 'server.js',
    instances: 'max',
    exec_mode: 'cluster',
    max_memory_restart: '1G',
    env_production: {
      NODE_ENV: 'production',
      PORT: 8080
    }
  }]
};
```

## PM2 with Docker
```bash
# Use PM2 in Docker
# Dockerfile
FROM node:18-alpine
RUN npm install pm2 -g
COPY . .
RUN npm install
EXPOSE 8080
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
```

## Useful Aliases
```bash
# Add to .zshrc or .bashrc
alias pmls='pm2 list'
alias pmlog='pm2 logs'
alias pmmon='pm2 monit'
alias pmstart='pm2 start'
alias pmstop='pm2 stop'
alias pmrestart='pm2 restart'
alias pmreload='pm2 reload'
alias pmsave='pm2 save'
alias pmres='pm2 resurrect'
```

## Common PM2 Patterns
```bash
# Start API server with clustering
pm2 start api.js -i max --name "api-cluster"

# Start with memory limit and auto-restart
pm2 start app.js --max-memory-restart 500M --name "memory-limited"

# Start with file watching for development
pm2 start app.js --watch --ignore-watch="node_modules logs" --name "dev-app"

# Start multiple apps
pm2 start app1.js && pm2 start app2.js && pm2 start app3.js

# Start with cron restart (restart every day at midnight)
pm2 start app.js --cron-restart="0 0 * * *"
```