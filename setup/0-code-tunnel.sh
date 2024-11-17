# run on proxmox debian host

apt update && apt upgrade -y && apt install dbus-user-session && systemctl --user enable dbus --now
curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
tar -xf vscode_cli.tar.gz
rm vscode_cli.tar.gz
mv code /usr/local/bin/
chmod +x /usr/local/bin/code
code version use stable --install-dir /usr/local/bin/code
code tunnel
code tunnel service install
loginctl enable-linger $USER
reboot