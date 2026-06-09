#!/usr/bin/env bash
set -euo pipefail
# meta:update: true
function update_inotify_settings() {
  echo "Updating inotify settings"
  sudo tee /etc/sysctl.d/99-inotify.conf > /dev/null << 'EOF'
fs.inotify.max_user_watches=1638400
fs.inotify.max_user_instances=1638400
EOF
  sudo sysctl --system
  echo "Inotify settings updated"
}

function setup_global_font_config() {
  echo "Setting up global font configuration"
  sudo tee /etc/fonts/local.conf > /dev/null << 'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
 <alias>
   <family>sans-serif</family>
   <prefer>
     <family>Noto Sans</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
     <family>DejaVu Sans</family>
   </prefer> 
 </alias>

 <alias>
   <family>serif</family>
   <prefer>
     <family>Noto Serif</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
     <family>DejaVu Serif</family>
   </prefer>
 </alias>

 <alias>
  <family>monospace</family>
  <prefer>
    <family>Noto Mono</family>
    <family>Noto Color Emoji</family>
    <family>Noto Emoji</family>
   </prefer>
 </alias>
</fontconfig>
EOF
  echo "Global font configuration set up"
}

update_inotify_settings
setup_global_font_config