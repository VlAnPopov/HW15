#!/bin/bash
# Разрешаем вход по паролю
# sed -i 's/^\#PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^\PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
systemctl restart sshd.service
# Создаём пользователей
useradd otusadm
useradd otus
chpasswd <<< 'otusadm:Otus2024!'
chpasswd <<< 'otus:Otus2024!'
sudo groupadd -f admin
usermod otusadm -a -G admin
usermod root -a -G admin
usermod vagrant -a -G admin
# Забираем скрипт контроля доступа
cp /vagrant/login.sh /usr/local/bin
chmod +x /usr/local/bin/login.sh
# и пишем конфигурацию pam для sshd
cp -f /vagrant/sshd /etc/pam.d/sshd
sudo groupadd -f docker
sudo usermod otusadm -aG docker
