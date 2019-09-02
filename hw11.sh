#! /usr/bin/env bash

sudo su
useradd admin
useradd adminassistant1
useradd adminassistant2
useradd administrator
usermod -aG wheel administrator
usermod -aG admin adminassistant1
usermod -g admin adminassistant1
usermod -aG admin adminassistant2
usermod -g admin adminassistant2
useradd moron1
useradd moron2

yum install mc -y

echo "@midnight root /home/vagrant/lock-unlock.sh" >> /etc/crontab
echo "@reboot root /home/vagrant/lock-unlock.sh" >> /etc/crontab
sed -i 's/.*admin:!!:18141:0:99999:7:::.*/admin:$1$S9nvl4U8$qaS8hBHyiwrTW5roF9RFb0:18141:0:99999:7:::/' /etc/shadow
sed -i 's/.*adminassistant1:!!:18141:0:99999:7:::.*/adminassistant1:$1$S9nvl4U8$qaS8hBHyiwrTW5roF9RFb0:18141:0:99999:7:::/' /etc/shadow
sed -i 's/.*adminassistant2:!!:18141:0:99999:7:::.*/adminassistant2:$1$S9nvl4U8$qaS8hBHyiwrTW5roF9RFb0:18141:0:99999:7:::/' /etc/shadow
sed -i 's/.*administrator:!!:18141:0:99999:7:::.*/administrator:$1$S9nvl4U8$qaS8hBHyiwrTW5roF9RFb0:18141:0:99999:7:::/' /etc/shadow
sed -i 's/.*moron1:!!:18141:0:99999:7:::.*/moron1:$1$S9nvl4U8$qaS8hBHyiwrTW5roF9RFb0:18141:0:99999:7:::/' /etc/shadow
sed -i 's/.*moron2:!!:18141:0:99999:7:::.*/moron2:$1$S9nvl4U8$qaS8hBHyiwrTW5roF9RFb0:18141:0:99999:7:::/' /etc/shadow

echo "administrator	ALL=(ALL)	ALL" >> /etc/sudoers

cp /home/vagrant/lock-unlock.sh /root/lock-unlock.sh
cp /home/vagrant/daysoff /root/daysoff
