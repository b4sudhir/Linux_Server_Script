read -p "Enter Username for MQTT: " user
stty -echo
read -p "Enter Password : " pass
stty echo
sudo apt update -y
sudo apt install -y mosquitto
sudo apt install -y mosquitto-clients
sudo touch /etc/mosquitto/conf.d/default.conf
sudo echo "bind_address 0.0.0.0
allow_anonymous false
password_file /etc/mosquitto/passwd
acl_file /etc/mosquitto/aclfile.example" > /etc/mosquitto/conf.d/default.conf
sudo echo "$user:$pass" > /etc/mosquitto/passwd
sudo mosquitto_passwd -U /etc/mosquitto/passwd
sudo echo "topic read $SYS/#
user  $user
topic readwrite #
pattern write $SYS/broker/connection/%c/state" > /etc/mosquitto/aclfile.example
sudo systemctl restart mosquitto
sudo chmod 666 /etc/mosquitto/passwd
sudo chmod 666 /etc/mosquitto/aclfile.example
sudo echo "
iot4all ALL=NOPASSWD: /usr/bin/mosquitto_passwd, /usr/lib/systemd, /bin/systemctl restart mosquitto.service, /bin/kill
" >> /etc/sudoers
sudo apt install -y php-pear
sudo pear install mail
sudo pear channel-update pear.php.net
sudo pear install Net_SMTP-1.10.0

sudo echo "
persistence false
# websockets
listener 9001
protocol websockets
certfile /etc/mosquitto/certs/iot4all.in.crt
keyfile  /etc/mosquitto/certs/iot4all.in.key
cafile /etc/mosquitto/ca_certificates/ca.crt
" >> /etc/mosquitto/mosquitto.conf

/* SSL ca.cert genration */ 
//http://www.steves-internet-guide.com/mosquitto-tls/
//Follow above path and create all keys.
//copy ca.crt files in mosquito/ca_certificates folder
//copy iot4all.in.crt & key files from /etc/nginx/ssl-certificates/ into certs folders
//add ports in cloudpanel 1883,9001,8080,8442,9443
//blynksetup
/*
1)    sudo add-apt-repository ppa:openjdk-r/ppa \
    && sudo apt-get update -q \
    && sudo apt install -y openjdk-11-jdk

2) crontab -e
@reboot java -jar /home/iot/blynk/server-0.41.16-java8.jar -dataFolder /home/iot/blynk

3) sudo reboot
4) ps -aux | grep java
*/

