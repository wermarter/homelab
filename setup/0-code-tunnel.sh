sudo apt update && sudo apt upgrade -y
curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
tar -xf vscode_cli.tar.gz
rm vscode_cli.tar.gz
sudo mv code /usr/local/bin/
sudo chmod +x /usr/local/bin/code
code version use stable --install-dir /usr/local/bin/code
code tunnel
code tunnel service install
sudo loginctl enable-linger $USER
sudo reboot