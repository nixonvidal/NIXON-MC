sudo apt update
sudo apt upgrade -y
sudo apt install curl wget git -y
sudo apt install ffmpeg webp -y
sudo curl https://deb.nodesource.com/setup_16.x | bash
sudo apt install nodejs -y
git clone https://github.com/Rizky878/rzky-multidevice/
cd rzky-multidevice
npm install --arch=x64 --platform=linux sharp
npm start
# Scan QR