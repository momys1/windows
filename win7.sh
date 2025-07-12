clear
echo "The owner of this script will not be responsible if any unexpected problems occur whether you edit this script or not. It will start in 10 seconds and you agree to this. To cancel press Ctrl + C."
sleep 10
clear
echo "New to Ngrok? Create an account or get token here: https://dashboard.ngrok.com/get-started/your-authtoken"
echo 
echo "-"
echo 
read -p $'\e[1;37mEnter your ngrok token: \e[0m' token
clear
sudo apt update -y
sudo apt install apache2 ufw p7zip-full aria2 qemu-system-x86-64 -y
sudo ufw allow 'VNC'
sudo ufw status
clear
if [ -e "./Tiny7.qcow2" ]; then
    echo "File exists"
else
    aria2c -x 4 -o file.7z 'https://archive.org/download/tiny-7.7z/Tiny7.7z'
    7za x file.7z
    rm -rf file.7z
fi
clear
if [ -e "./ngrok" ]; then
    echo "File exists"
else
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
    tar -xvzf ngrok-v3-stable-linux-amd64.tgz
    rm -rf ngrok-v3-stable-linux-amd64.tgz
fi
./ngrok authtoken "$token"
echo 'rungrok="$(./ngrok tcp 5900)" &' > start7.sh
echo "clear" >> start7.sh
echo 'echo "Just a moment..."' >> start7.sh
echo "sleep 10" >> start7.sh
echo "clear" >> start7.sh
echo 'echo "The address to connect to via VNC is below. If you do not see anything below, try checking here: https://dashboard.ngrok.com/agents"' >> start7.sh
echo "echo " >> start7.sh
echo 'echo "-"' >> start7.sh
echo "echo " >> start7.sh
echo "curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url\":\"tcp:..([^\"]*).*/\1/p'" >> start7.sh
echo "sleep 10" >> start7.sh
echo "sudo qemu-system-x86_64 -usb -device usb-tablet -device usb-kbd -cpu qemu64,+sse,+sse2,+sse4.1,+sse4.2 -smp sockets=1,cores=4,threads=1 -overcommit mem-lock=off -m 2048M -drive file=Tiny7.qcow2,aio=threads,cache=unsafe -device qxl-vga,vgamem_mb=128 -device ac97 -device rtl8139,netdev=n0 -netdev user,id=n0 -accel tcg,thread=multi,tb-size=2048 -vnc :0"  >> start7.sh
echo "clear" >> start7.sh
echo 'echo "To run again, run the following command:"' >> start7.sh
echo "echo " >> start7.sh
echo 'echo "-"' >> start7.sh
echo "echo " >> start7.sh
echo 'echo "./start7.sh"' >> start7.sh
chmod +x start7.sh
./start7.sh
