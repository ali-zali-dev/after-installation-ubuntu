# Docker CLI Commands

## Basic Container Operations
```bash
# List containers
docker ps                    # Running containers
docker ps -a                 # All containers
docker ps -q                 # Only container IDs

# Run containers
docker run <image>
docker run -d <image>        # Detached mode
docker run -it <image> bash  # Interactive with terminal
docker run --name <name> <image>
docker run -p 8080:80 <image>  # Port mapping

# Start/stop/restart containers
docker start <container>
docker stop <container>
docker restart <container>
docker kill <container>      # Force stop
```

## Container Management
```bash
# Remove containers
docker rm <container>
docker rm $(docker ps -aq)   # Remove all containers
docker container prune       # Remove stopped containers

# Execute commands in running container
docker exec -it <container> bash
docker exec <container> <command>

# Copy files to/from container
docker cp <file> <container>:/path/
docker cp <container>:/path/<file> ./

# View container logs
docker logs <container>
docker logs -f <container>    # Follow logs
docker logs --tail 50 <container>
```

## Image Operations
```bash
# List images
docker images
docker image ls

# Pull/push images
docker pull <image>
docker push <image>

# Build images
docker build .
docker build -t <name:tag> .
docker build -f Dockerfile.dev .

# Remove images
docker rmi <image>
docker image prune           # Remove unused images
docker system prune          # Remove unused containers, images, networks
```

## Volume Management
```bash
# List volumes
docker volume ls

# Create volume
docker volume create <volume-name>

# Mount volumes
docker run -v <volume>:/path <image>
docker run -v /host/path:/container/path <image>
docker run --mount source=<volume>,target=/path <image>

# Remove volumes
docker volume rm <volume>
docker volume prune
```

## Network Operations
```bash
# List networks
docker network ls

# Create network
docker network create <network-name>
docker network create --driver bridge <network-name>

# Connect container to network
docker network connect <network> <container>
docker network disconnect <network> <container>

# Inspect network
docker network inspect <network>

# Remove network
docker network rm <network>
docker network prune
```

## Docker Compose Commands
```bash
# Start services
docker compose up
docker compose up -d         # Detached mode
docker compose up --build    # Rebuild images

# Stop services
docker compose down
docker compose down -v       # Remove volumes
docker compose stop

# View logs
docker compose logs
docker compose logs <service>
docker compose logs -f       # Follow logs

# Scale services
docker compose up --scale <service>=3

# Execute commands
docker compose exec <service> bash
docker compose run <service> <command>
```

## Inspection and Debugging
```bash
# Inspect containers/images
docker inspect <container/image>
docker stats                 # Resource usage
docker stats <container>

# View processes in container
docker top <container>

# View container filesystem changes
docker diff <container>

# Export/import containers
docker export <container> > backup.tar
docker import backup.tar <image-name>

# Save/load images
docker save <image> > image.tar
docker load < image.tar
```

## Registry Operations
```bash
# Login to registry
docker login
docker login <registry-url>

# Tag images
docker tag <image> <registry>/<image>:<tag>

# Search Docker Hub
docker search <term>

# Get image information
docker image inspect <image>
docker image history <image>
```

## System Information
```bash
# System information
docker info
docker version
docker system df            # Disk usage
docker system events        # Real-time events

# Clean up system
docker system prune
docker system prune -a      # Remove all unused images
docker system prune --volumes  # Include volumes
```

## Useful Docker Aliases
```bash
# Add to .zshrc or .bashrc
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dstop='docker stop'
alias dstart='docker start'
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune'

# Docker compose aliases
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcl='docker compose logs'
alias dce='docker compose exec'
```

## Common Docker Patterns
```bash
# Run temporary container that auto-removes
docker run --rm -it <image>

# Run with environment variables
docker run -e VAR=value <image>
docker run --env-file .env <image>

# Run with resource limits
docker run -m 512m --cpus="1.0" <image>

# Run with restart policy
docker run --restart=unless-stopped <image>

# Mount current directory
docker run -v $(pwd):/app <image>

# Run with specific user
docker run --user $(id -u):$(id -g) <image>
```