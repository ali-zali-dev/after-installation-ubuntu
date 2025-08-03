# GNOME Settings CLI Commands

## gsettings (GNOME Settings)
```bash
# List all schemas
gsettings list-schemas

# List keys in a schema
gsettings list-keys org.gnome.desktop.interface

# Get current value
gsettings get org.gnome.desktop.interface clock-show-seconds

# Set value
gsettings set org.gnome.desktop.interface clock-show-seconds true

# Reset to default
gsettings reset org.gnome.desktop.interface clock-show-seconds

# Watch for changes
gsettings monitor org.gnome.desktop.interface
```

## Desktop Interface Settings
```bash
# Show seconds in clock
gsettings set org.gnome.desktop.interface clock-show-seconds true

# Dark theme
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Icon theme
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'

# Cursor theme and size
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.desktop.interface cursor-size 24

# Font settings
gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 10'

# Show battery percentage
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Animation settings
gsettings set org.gnome.desktop.interface enable-animations true
```

## Window Manager Settings
```bash
# Window button layout
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# Focus mode
gsettings set org.gnome.desktop.wm.preferences focus-mode 'click'

# Window titlebar actions
gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'lower'

# Workspace settings
gsettings set org.gnome.mutter dynamic-workspaces true
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4

# Auto-hide top bar
gsettings set org.gnome.shell.behavior.panel auto-hide true
```

## Keyboard and Input Settings
```bash
# Keyboard repeat settings
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30

# Touchpad settings
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true

# Mouse settings
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.mouse speed 0.0

# Input sources (keyboard layouts)
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'es')]"
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:alt_shift_toggle']"
```

## Display and Monitor Settings
```bash
# Night light (blue light filter)
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4000
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true

# Screen timeout
gsettings set org.gnome.desktop.session idle-delay 900  # 15 minutes

# Screen brightness
gsettings set org.gnome.settings-daemon.plugins.power idle-brightness 30
```

## Privacy and Security Settings
```bash
# Location services
gsettings set org.gnome.system.location enabled false

# Recent files
gsettings set org.gnome.desktop.privacy remember-recent-files true
gsettings set org.gnome.desktop.privacy recent-files-max-age 30

# Remove old temp files
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy old-files-age 30

# Remove old trash files
gsettings set org.gnome.desktop.privacy remove-old-trash-files true

# Report technical problems
gsettings set org.gnome.desktop.privacy report-technical-problems false
```

## Power Management
```bash
# Power button action
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'

# Sleep settings
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600

# Battery settings
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800
```

## Sound Settings
```bash
# Event sounds
gsettings set org.gnome.desktop.sound event-sounds true

# Volume settings
gsettings set org.gnome.desktop.sound input-feedback-sounds false

# Alert sound
gsettings set org.gnome.desktop.sound theme-name 'freedesktop'
```

## Files (Nautilus) Settings
```bash
# Default view
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'

# Show hidden files
gsettings set org.gnome.nautilus.preferences show-hidden-files true

# Executable text files
gsettings set org.gnome.nautilus.preferences executable-text-activation 'ask'

# Sort directories first
gsettings set org.gnome.nautilus.preferences sort-directories-first true

# Show image thumbnails
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
```

## GNOME Extensions Management
```bash
# List installed extensions
gnome-extensions list

# Enable extension
gnome-extensions enable extension-id@domain.com

# Disable extension
gnome-extensions disable extension-id@domain.com

# Show extension info
gnome-extensions info extension-id@domain.com

# Reset extension
gnome-extensions reset extension-id@domain.com

# Install extension (from local file)
gnome-extensions install extension.zip
```

## Keybindings Management
```bash
# List all keybindings
gsettings list-recursively | grep -E "(keybinding|shortcut)"

# Window management shortcuts
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Alt>F10']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"

# Custom shortcuts
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Ctrl><Alt>t'
```

## Backup and Restore Settings
```bash
# Backup all GNOME settings
dconf dump / > gnome-settings-backup.conf

# Restore GNOME settings
dconf load / < gnome-settings-backup.conf

# Backup specific schema
dconf dump /org/gnome/desktop/interface/ > interface-settings.conf

# Reset all settings to defaults
dconf reset -f /
```

## Useful Shell Functions
```bash
# Add to .zshrc or .bashrc

# Toggle dark mode
toggle-dark-mode() {
    current=$(gsettings get org.gnome.desktop.interface color-scheme)
    if [[ $current == "'prefer-dark'" ]]; then
        gsettings set org.gnome.desktop.interface color-scheme 'default'
        echo "Switched to light mode"
    else
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        echo "Switched to dark mode"
    fi
}

# Quick screenshot hotkey setup
setup-screenshot-hotkeys() {
    gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "['Print']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "['<Shift>Print']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "['<Alt>Print']"
    echo "Screenshot hotkeys configured"
}

# Performance mode (disable animations)
performance-mode() {
    gsettings set org.gnome.desktop.interface enable-animations false
    gsettings set org.gnome.desktop.interface gtk-enable-animations false
    echo "Performance mode enabled (animations disabled)"
}

# Restore animations
restore-animations() {
    gsettings set org.gnome.desktop.interface enable-animations true
    gsettings set org.gnome.desktop.interface gtk-enable-animations true
    echo "Animations restored"
}

# Show current theme info
theme-info() {
    echo "GTK Theme: $(gsettings get org.gnome.desktop.interface gtk-theme)"
    echo "Icon Theme: $(gsettings get org.gnome.desktop.interface icon-theme)"
    echo "Color Scheme: $(gsettings get org.gnome.desktop.interface color-scheme)"
    echo "Cursor Theme: $(gsettings get org.gnome.desktop.interface cursor-theme)"
}
```

## Monitoring and Debugging
```bash
# Monitor all setting changes
gsettings monitor org.gnome.desktop.interface

# Monitor specific key changes
gsettings monitor org.gnome.desktop.interface clock-show-seconds

# Check GNOME session
echo $XDG_CURRENT_DESKTOP
echo $GNOME_DESKTOP_SESSION_ID

# GNOME logs
journalctl -f | grep -i gnome
journalctl -f | grep -i gdm
```

## Extension Development
```bash
# Create extension template
gnome-extensions create

# Pack extension
gnome-extensions pack extension-directory/

# Install packed extension
gnome-extensions install extension.zip

# Reload GNOME Shell (X11 only)
killall -HUP gnome-shell

# Reload GNOME Shell (Wayland - requires logout/login)
gnome-session-quit --logout
```

## Useful Aliases
```bash
# Add to .zshrc or .bashrc
alias gsget='gsettings get'
alias gsset='gsettings set'
alias gsreset='gsettings reset'
alias gslist='gsettings list-keys'
alias gnome-backup='dconf dump / > gnome-backup-$(date +%Y%m%d).conf'
alias gnome-restore='dconf load / <'
alias extensions='gnome-extensions list'
alias dark-mode='gsettings set org.gnome.desktop.interface color-scheme prefer-dark'
alias light-mode='gsettings set org.gnome.desktop.interface color-scheme default'
```