# Flameshot CLI Commands

## Installation
```bash
# Install Flameshot
sudo apt install flameshot

# Verify installation
flameshot --version
```

## Basic Screenshot Commands
```bash
# Take screenshot with GUI
flameshot gui

# Take fullscreen screenshot
flameshot full

# Take screenshot and save to file
flameshot gui --path ~/Pictures/screenshots/

# Take fullscreen screenshot and save
flameshot full --path ~/Pictures/screenshots/screenshot.png

# Take screenshot and copy to clipboard
flameshot gui --clipboard

# Take screenshot with delay
flameshot gui --delay 3000   # 3 second delay (in milliseconds)
```

## Advanced Screenshot Options
```bash
# Screenshot specific area and save
flameshot gui --path ~/Pictures/ --delay 2000

# Take screenshot without GUI (direct save)
flameshot screen --path ~/Pictures/screenshot.png

# Take screenshot of specific screen (multi-monitor)
flameshot screen --number 1 --path ~/Pictures/screen1.png

# Take screenshot and upload (if configured)
flameshot gui --upload

# Print help
flameshot --help
flameshot gui --help
```

## Configuration and Settings
```bash
# Show configuration location
flameshot config

# Launch configuration GUI
flameshot config

# Reset configuration to defaults
rm ~/.config/flameshot/flameshot.ini
```

## Automation and Scripting
```bash
# Create timestamped screenshots
flameshot gui --path ~/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).png

# Create organized screenshot directory
mkdir -p ~/Pictures/screenshots/$(date +%Y)/$(date +%m)
flameshot gui --path ~/Pictures/screenshots/$(date +%Y)/$(date +%m)/

# Batch screenshot script
#!/bin/bash
SCREENSHOT_DIR="$HOME/Pictures/screenshots"
mkdir -p "$SCREENSHOT_DIR"
FILENAME="screenshot_$(date +%Y%m%d_%H%M%S).png"
flameshot gui --path "$SCREENSHOT_DIR/$FILENAME"
echo "Screenshot saved to: $SCREENSHOT_DIR/$FILENAME"
```

## Keyboard Shortcuts Setup
```bash
# Set up custom keyboard shortcuts in system settings
# GUI Screenshot: flameshot gui
# Fullscreen: flameshot full
# Delayed Screenshot: flameshot gui --delay 3000

# Common keyboard shortcuts to set:
# Print Screen: flameshot gui
# Ctrl+Print Screen: flameshot full
# Shift+Print Screen: flameshot gui --clipboard
```

## Integration with Other Tools
```bash
# Combine with image processing
flameshot gui --path /tmp/temp_screenshot.png && \
convert /tmp/temp_screenshot.png -quality 85 ~/Pictures/compressed_screenshot.jpg

# Upload to image hosting (with curl)
flameshot gui --path /tmp/screenshot.png && \
curl -F "file=@/tmp/screenshot.png" https://0x0.st

# OCR text recognition (with tesseract)
flameshot gui --path /tmp/screenshot.png && \
tesseract /tmp/screenshot.png /tmp/screenshot_text && \
cat /tmp/screenshot_text.txt
```

## Useful Shell Functions
```bash
# Add to .zshrc or .bashrc

# Quick screenshot with timestamp
screenshot() {
    local dir="$HOME/Pictures/screenshots"
    mkdir -p "$dir"
    local filename="screenshot_$(date +%Y%m%d_%H%M%S).png"
    flameshot gui --path "$dir/$filename"
    echo "Screenshot saved: $dir/$filename"
}

# Screenshot and copy path to clipboard
screenshot-copy-path() {
    local dir="$HOME/Pictures/screenshots"
    mkdir -p "$dir"
    local filename="screenshot_$(date +%Y%m%d_%H%M%S).png"
    flameshot gui --path "$dir/$filename"
    echo "$dir/$filename" | xclip -selection clipboard
    echo "Screenshot saved and path copied to clipboard"
}

# Quick fullscreen screenshot
fullscreen() {
    local dir="$HOME/Pictures/screenshots"
    mkdir -p "$dir"
    local filename="fullscreen_$(date +%Y%m%d_%H%M%S).png"
    flameshot full --path "$dir/$filename"
    echo "Fullscreen saved: $dir/$filename"
}

# Screenshot with custom delay
screenshot-delay() {
    local delay=${1:-5}  # Default 5 seconds
    local dir="$HOME/Pictures/screenshots"
    mkdir -p "$dir"
    local filename="delayed_screenshot_$(date +%Y%m%d_%H%M%S).png"
    echo "Taking screenshot in $delay seconds..."
    flameshot gui --delay $((delay * 1000)) --path "$dir/$filename"
}
```

## Configuration File Example
```ini
# ~/.config/flameshot/flameshot.ini
[General]
disabledTrayIcon=false
showStartupLaunchMessage=false
savePath=/home/user/Pictures/screenshots
savePathFixed=true
showHelp=false
showSidePanelButton=true
showDesktopNotification=true
filename=screenshot_%Y%m%d_%H%M%S
allowMultipleGuiInstances=false

[Shortcuts]
TYPE_ARROW=A
TYPE_CIRCLE=C
TYPE_COPY=Return
TYPE_DRAWER=D
TYPE_EXIT=Ctrl+Q
TYPE_IMAGEUPLOADER=Return
TYPE_MARKER=M
TYPE_MOVESELECTION=Ctrl+M
TYPE_OPEN_APP=Ctrl+O
TYPE_PENCIL=P
TYPE_PIN=Ctrl+P
TYPE_RECTANGLE=R
TYPE_REDO=Ctrl+Y
TYPE_SAVE=Ctrl+S
TYPE_SELECTION=S
TYPE_SELECTIONINDICATOR=
TYPE_TEXT=T
TYPE_TOGGLE_PANEL=Space
TYPE_UNDO=Ctrl+Z
```

## GUI Features and Shortcuts
```bash
# When using flameshot gui, these keyboard shortcuts are available:
# - Spacebar: Toggle side panel
# - Ctrl+C: Copy to clipboard
# - Ctrl+S: Save to file
# - Ctrl+Z: Undo
# - Ctrl+Y: Redo
# - Enter: Copy/save selection
# - Escape: Exit without saving
# - Mouse wheel: Resize selection
# - Arrow keys: Move selection
```

## Common Use Cases
```bash
# Quick bug reporting screenshot
bug-report() {
    local bug_dir="$HOME/Pictures/bug-reports"
    mkdir -p "$bug_dir"
    local filename="bug_$(date +%Y%m%d_%H%M%S).png"
    flameshot gui --path "$bug_dir/$filename"
    echo "Bug report screenshot: $bug_dir/$filename"
}

# Documentation screenshots
docs-screenshot() {
    local docs_dir="$HOME/Pictures/documentation"
    mkdir -p "$docs_dir"
    local filename="docs_$(date +%Y%m%d_%H%M%S).png"
    flameshot gui --path "$docs_dir/$filename"
}

# Social media screenshot (square crop suggested)
social-screenshot() {
    local social_dir="$HOME/Pictures/social"
    mkdir -p "$social_dir"
    local filename="social_$(date +%Y%m%d_%H%M%S).png"
    flameshot gui --path "$social_dir/$filename"
    echo "Remember to crop to square format for social media!"
}
```

## Troubleshooting
```bash
# Check if Flameshot is running
ps aux | grep flameshot

# Kill Flameshot process
pkill flameshot

# Check Flameshot logs
journalctl -f | grep flameshot

# Reset Flameshot configuration
mv ~/.config/flameshot ~/.config/flameshot.backup
flameshot config  # Will create new default config

# Check system screenshot capabilities
which flameshot
flameshot --version
echo $XDG_SESSION_TYPE  # Should show x11 or wayland
```

## Aliases
```bash
# Add to .zshrc or .bashrc
alias fs='flameshot gui'
alias fss='flameshot gui --clipboard'
alias fsf='flameshot full'
alias fsd='flameshot gui --delay 3000'
alias fsc='flameshot config'

# Screenshot directory shortcut
alias screenshots='cd ~/Pictures/screenshots && ls -la'
```

## Integration with Window Managers
```bash
# For i3wm, add to config:
# bindsym Print exec flameshot gui
# bindsym Ctrl+Print exec flameshot full
# bindsym Shift+Print exec flameshot gui --clipboard

# For awesome wm, add to rc.lua:
# awful.key({}, "Print", function() awful.spawn("flameshot gui") end),

# For bspwm, add to sxhkdrc:
# Print
#     flameshot gui
```