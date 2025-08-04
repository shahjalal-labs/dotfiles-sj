#!/bin/bash

# ==================================================
# RANGER AS DEFAULT FILE PICKER SETUP
# ==================================================

echo "🔧 Setting up Ranger as default file picker..."

# Method 1: Create ranger-picker wrapper script
create_ranger_picker() {
    cat > ~/.local/bin/ranger-picker << 'EOF'
#!/bin/bash

# Ranger File Picker Wrapper
# This script makes ranger work as a GUI file picker

SELECTION_FILE=$(mktemp)
TITLE="${1:-Select File}"

# Use terminal emulator to run ranger
if command -v kitty >/dev/null 2>&1; then
    TERMINAL="kitty --title='$TITLE'"
elif command -v alacritty >/dev/null 2>&1; then
    TERMINAL="alacritty --title '$TITLE' -e"
elif command -v gnome-terminal >/dev/null 2>&1; then
    TERMINAL="gnome-terminal --title='$TITLE' --"
elif command -v xterm >/dev/null 2>&1; then
    TERMINAL="xterm -T '$TITLE' -e"
else
    echo "No suitable terminal found" >&2
    exit 1
fi

# Run ranger with file selection
$TERMINAL bash -c "
ranger --choosefile='$SELECTION_FILE'
"

# Output selected file(s)
if [[ -f '$SELECTION_FILE' && -s '$SELECTION_FILE' ]]; then
    cat '$SELECTION_FILE'
    rm '$SELECTION_FILE'
    exit 0
else
    rm -f '$SELECTION_FILE'
    exit 1
fi
EOF

    chmod +x ~/.local/bin/ranger-picker
    echo "✅ Created ranger-picker script"
}

# Method 2: Create .desktop file for ranger file manager
create_desktop_file() {
    mkdir -p ~/.local/share/applications
    
    cat > ~/.local/share/applications/ranger-filepicker.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Ranger File Manager
Comment=File picker using Ranger
Exec=ranger-picker %F
Icon=folder
StartupNotify=true
NoDisplay=false
MimeType=inode/directory;
Categories=System;FileTools;FileManager;
EOF

    echo "✅ Created ranger-filepicker.desktop"
}

# Method 3: Update xdg-mime associations
set_default_file_manager() {
    echo "🔄 Setting ranger as default file manager..."
    
    # Set as default for directories
    xdg-mime default ranger-filepicker.desktop inode/directory
    
    # Set for file selection dialogs (if supported)
    xdg-mime default ranger-filepicker.desktop application/x-file-manager
    
    echo "✅ Updated MIME associations"
}

# Method 4: Firefox specific configuration
setup_firefox_integration() {
    echo "🦊 Firefox Integration Notes:"
    echo "1. Open Firefox → about:config"
    echo "2. Search for: widget.use-xdg-desktop-portal"
    echo "3. Set to: true"
    echo "4. Restart Firefox"
    echo ""
    echo "Alternative: Set these in about:config:"
    echo "- widget.use-xdg-desktop-portal.file-picker = 1"
    echo "- widget.use-xdg-desktop-portal.mime-handler = 1"
}

# Method 5: Environment variables
setup_environment() {
    echo "🌍 Adding environment variables..."
    
    # Add to shell profile
    SHELL_PROFILE=""
    if [[ -f ~/.zshrc ]]; then
        SHELL_PROFILE=~/.zshrc
    elif [[ -f ~/.bashrc ]]; then
        SHELL_PROFILE=~/.bashrc
    fi
    
    if [[ -n "$SHELL_PROFILE" ]]; then
        echo "" >> "$SHELL_PROFILE"
        echo "# Ranger as file picker" >> "$SHELL_PROFILE"
        echo "export FILE_MANAGER=ranger-picker" >> "$SHELL_PROFILE"
        echo "✅ Added to $SHELL_PROFILE"
    fi
}

# Method 6: Portal configuration for modern desktop environments
setup_xdg_portal() {
    mkdir -p ~/.config/xdg-desktop-portal
    
    cat > ~/.config/xdg-desktop-portal/portals.conf << 'EOF'
[preferred]
default=gtk
org.freedesktop.impl.portal.FileChooser=gtk
EOF

    echo "✅ Configured XDG Desktop Portal"
    echo "Note: You may need to install xdg-desktop-portal-gtk"
}

# Execute setup
main() {
    echo "🚀 Starting Ranger File Picker Setup..."
    echo ""
    
    # Ensure .local/bin exists and is in PATH
    mkdir -p ~/.local/bin
    
    create_ranger_picker
    create_desktop_file
    set_default_file_manager
    setup_environment
    setup_xdg_portal
    
    echo ""
    echo "✅ Setup Complete!"
    echo ""
    echo "📋 Manual Steps Required:"
    setup_firefox_integration
    echo ""
    echo "🔄 To activate changes:"
    echo "1. Log out and log back in (or reboot)"
    echo "2. Run: update-desktop-database ~/.local/share/applications"
    echo "3. Source your shell: source ~/.zshrc (or ~/.bashrc)"
    echo ""
    echo "🧪 Test with: xdg-open ."
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
