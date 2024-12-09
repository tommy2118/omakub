# Install chruby for managing Ruby versions. See https://github.com/postmodern/chruby
sudo apt update -y && sudo apt install -y wget curl
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://keybase.io/postmodern/key.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/chruby-archive-keyring.gpg 1>/dev/null
echo "deb [signed-by=/etc/apt/keyrings/chruby-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://apt.postmodern.dev stable main" | sudo tee /etc/apt/sources.list.d/chruby.list
sudo apt update
sudo apt install -y chruby
