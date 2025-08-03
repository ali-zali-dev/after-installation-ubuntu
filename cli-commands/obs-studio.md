# OBS Studio CLI Commands

## Installation
```bash
# Install OBS Studio
sudo apt install obs-studio

# Install via snap
sudo snap install obs-studio

# Verify installation
obs --version
```

## Basic CLI Operations
```bash
# Launch OBS Studio
obs

# Launch with specific scene collection
obs --scene-collection "My Collection"

# Launch with specific profile
obs --profile "My Profile"

# Launch minimized to system tray
obs --minimize-to-tray

# Launch with verbose logging
obs --verbose

# Launch without plugins
obs --safe-mode

# Show help
obs --help
```

## OBS WebSocket Commands (requires obs-websocket plugin)
```bash
# Install obs-websocket plugin first
# Then use tools like obs-cli or custom scripts

# Example using curl to interact with OBS WebSocket API
# Start recording
curl -X POST http://localhost:4444 \
  -H "Content-Type: application/json" \
  -d '{"request-type": "StartRecording", "message-id": "1"}'

# Stop recording
curl -X POST http://localhost:4444 \
  -H "Content-Type: application/json" \
  -d '{"request-type": "StopRecording", "message-id": "2"}'

# Get current scene
curl -X POST http://localhost:4444 \
  -H "Content-Type: application/json" \
  -d '{"request-type": "GetCurrentScene", "message-id": "3"}'
```

## Configuration and Profiles
```bash
# OBS configuration directory
ls ~/.config/obs-studio/

# Profile management (via config files)
# Profiles are stored in ~/.config/obs-studio/basic/profiles/

# Scene collections (via config files)
# Scene collections are in ~/.config/obs-studio/basic/scenes/

# Backup OBS configuration
tar -czf obs-backup-$(date +%Y%m%d).tar.gz ~/.config/obs-studio/

# Restore OBS configuration
tar -xzf obs-backup.tar.gz -C ~/
```

## Recording and Streaming Automation
```bash
# Create a script to automate OBS recording
#!/bin/bash
# obs-record.sh

# Start OBS in background
obs --minimize-to-tray &
OBS_PID=$!

# Wait for OBS to start
sleep 5

# Send commands via WebSocket (requires obs-websocket)
# Start recording
echo "Starting recording..."
# (WebSocket command here)

# Record for specified duration
DURATION=${1:-60}  # Default 60 seconds
sleep $DURATION

# Stop recording
echo "Stopping recording..."
# (WebSocket command here)

# Close OBS
kill $OBS_PID
```

## FFmpeg Integration (for advanced users)
```bash
# OBS uses FFmpeg internally, you can also use FFmpeg directly

# Screen recording with audio
ffmpeg -f x11grab -s 1920x1080 -i :0.0 \
       -f pulse -i default \
       -c:v libx264 -preset fast -crf 23 \
       -c:a aac -b:a 128k \
       output.mp4

# Webcam recording
ffmpeg -f v4l2 -i /dev/video0 \
       -f pulse -i default \
       -c:v libx264 -preset fast \
       -c:a aac \
       webcam.mp4

# Stream to RTMP (like Twitch/YouTube)
ffmpeg -f x11grab -s 1920x1080 -i :0.0 \
       -f pulse -i default \
       -c:v libx264 -preset veryfast -b:v 2500k \
       -c:a aac -b:a 128k \
       -f flv rtmp://live.twitch.tv/live/YOUR_STREAM_KEY
```

## Automated Setup Scripts
```bash
# Setup OBS with common settings
#!/bin/bash
# obs-setup.sh

echo "Setting up OBS Studio..."

# Create recordings directory
mkdir -p ~/Videos/OBS-Recordings

# Create common scene collection
OBS_SCENES_DIR="$HOME/.config/obs-studio/basic/scenes"
mkdir -p "$OBS_SCENES_DIR"

# Basic scene collection JSON (simplified)
cat > "$OBS_SCENES_DIR/Desktop-Recording.json" << EOF
{
    "current_scene": "Desktop",
    "current_program_scene": "Desktop",
    "scene_order": [
        {
            "name": "Desktop"
        }
    ],
    "scenes": [
        {
            "name": "Desktop",
            "sources": [
                {
                    "name": "Desktop",
                    "type": "xshm_input"
                }
            ]
        }
    ]
}
EOF

echo "OBS setup complete!"
```

## Useful Shell Functions
```bash
# Add to .zshrc or .bashrc

# Quick screen recording
obs-record() {
    local duration=${1:-60}
    local output="$HOME/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4"
    
    echo "Starting $duration second recording..."
    echo "Output: $output"
    
    # Using ffmpeg as fallback if OBS automation isn't available
    timeout $duration ffmpeg -f x11grab -s 1920x1080 -i :0.0 \
                            -f pulse -i default \
                            -c:v libx264 -preset fast -crf 23 \
                            -c:a aac -b:a 128k \
                            "$output" 2>/dev/null
    
    echo "Recording saved to: $output"
}

# Quick webcam test
webcam-test() {
    ffplay -f v4l2 -i /dev/video0
}

# List available audio sources
list-audio() {
    pactl list sources short
}

# List available video devices
list-video() {
    v4l2-ctl --list-devices
}

# OBS log viewer
obs-logs() {
    tail -f ~/.config/obs-studio/logs/*.txt
}
```

## Plugins and Extensions
```bash
# Common OBS plugins to install:

# OBS WebSocket (for remote control)
# Download from GitHub and install manually

# OBS Browser Source (usually included)
# Allows web content in scenes

# OBS Virtual Camera (usually included in newer versions)
# Creates virtual webcam output

# StreamFX (advanced effects)
# Download from GitHub

# Plugin installation directory
ls ~/.config/obs-studio/plugins/
```

## Stream Setup Examples
```bash
# Twitch streaming configuration
# In OBS: Settings > Stream
# Service: Twitch
# Server: Auto (Recommended)
# Stream Key: (from Twitch dashboard)

# YouTube streaming configuration
# Service: YouTube - RTMPS
# Server: Primary YouTube ingest server
# Stream Key: (from YouTube Studio)

# Custom RTMP server
# Service: Custom
# Server: rtmp://your-server.com/live
# Stream Key: your-stream-key
```

## Troubleshooting Commands
```bash
# Check if OBS is running
ps aux | grep obs

# Kill OBS process
pkill obs

# Check OBS logs
cat ~/.config/obs-studio/logs/*.txt | tail -50

# Check system audio/video devices
# Audio devices
arecord -l
pactl list sources

# Video devices
ls /dev/video*
v4l2-ctl --list-devices

# Check system performance during recording
htop
nvidia-smi  # If using NVIDIA GPU

# Test audio recording
arecord -f cd -d 5 test.wav && aplay test.wav

# Test video capture
ffplay -f v4l2 -i /dev/video0
```

## Performance Optimization
```bash
# Check system resources
free -h
lscpu
nvidia-smi  # For NVIDIA users

# Optimize OBS settings via command line
# (These would typically be set in OBS GUI, but can be scripted)

# Monitor OBS performance
# Create monitoring script
#!/bin/bash
while true; do
    echo "$(date): $(ps -p $(pgrep obs) -o %cpu,%mem --no-headers)"
    sleep 5
done
```

## Keyboard Shortcuts (Global Hotkeys)
```bash
# Set up global hotkeys for OBS (configured in OBS GUI)
# Common hotkeys to configure:
# - Start/Stop Recording: Ctrl+Shift+R
# - Start/Stop Streaming: Ctrl+Shift+S
# - Toggle Mute: Ctrl+Shift+M
# - Scene switching: F1, F2, F3, etc.

# You can also use tools like xdotool to send keys to OBS
# Example: Start recording hotkey
xdotool search --name "OBS" windowactivate --sync key ctrl+shift+r
```

## Backup and Migration
```bash
# Backup OBS settings
backup-obs() {
    local backup_dir="$HOME/obs-backups"
    mkdir -p "$backup_dir"
    local backup_file="$backup_dir/obs-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
    tar -czf "$backup_file" -C "$HOME" .config/obs-studio
    echo "OBS backup created: $backup_file"
}

# Restore OBS settings
restore-obs() {
    local backup_file="$1"
    if [ -f "$backup_file" ]; then
        tar -xzf "$backup_file" -C "$HOME"
        echo "OBS settings restored from: $backup_file"
    else
        echo "Backup file not found: $backup_file"
    fi
}
```

## Useful Aliases
```bash
# Add to .zshrc or .bashrc
alias obs-start='obs --minimize-to-tray'
alias obs-safe='obs --safe-mode'
alias obs-verbose='obs --verbose'
alias obs-config='cd ~/.config/obs-studio'
alias obs-logs='tail -f ~/.config/obs-studio/logs/*.txt'
alias obs-backup='backup-obs'
```

## Integration with Other Tools
```bash
# Use with cron for scheduled recordings
# Add to crontab (crontab -e)
# 0 14 * * 1-5 /home/user/scripts/daily-recording.sh

# Integration with system notifications
notify-recording-start() {
    notify-send "OBS" "Recording started" --icon=obs
}

notify-recording-stop() {
    notify-send "OBS" "Recording stopped" --icon=obs
}

# Use with system startup
# Add to ~/.profile or create systemd service
# obs --minimize-to-tray &
```