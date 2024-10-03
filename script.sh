#!/bin/bash

# Untuk routing dari Router ke Switch agar dalam satu jaringan yang sama
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.78.0.0/16

# Update package list
sudo apt-get update

# Install BIND9 di DNS Server (Tanjungkulai, Bedahulu, Sriwijaya, dan Majapahit)
sudo apt-get install -y bind9 bind9utils bind9-doc

# Install Apache di kedua web server (Tanjungkulai dan Bedahulu)
sudo apt-get install -y bind9 bind9utils bind9-doc

# Konfigurasi DNS Master (Sriwijaya)
sudo bash -c 'cat << EOF >> /etc/bind/named.conf.local
zone "it16.com" {
    type master;
    file "/etc/bind/db.it16.com";
    allow-transfer { 192.241.3.4; };  # Izinkan transfer zona ke DNS Slave (Majapahit)
};
EOF'

# Buat file zona untuk DNS Master (Sriwijaya)
sudo bash -c 'cat << EOF > /etc/bind/db.it16.com
\$TTL 86400
@   IN  SOA ns1.it16.com. admin.it16.com. (
            2024010101   ; Serial
            3600         ; Refresh
            1800         ; Retry
            1209600      ; Expire
            86400 )      ; Negative Cache TTL

    IN  NS  ns1.xxxx.com.
ns1 IN  A   IP_Sriwijaya

# Domain Records
sudarsana.it16.com.    IN  A   192.241.1.3
www.sudarsana.it16.com.    IN  CNAME sudarsana.it16.com.

pasopati.it16.com.     IN  A   192.241.2.6
www.pasopati.it16.com. IN  CNAME pasopati.it16.com.

rujapala.it16.com.     IN  A   192.241.3.3
www.rujapala.it16.com. IN  CNAME rujapala.it16.com.

# Subdomain Records
cakra.sudarsana.it16.com.  IN  A   192.241.3.2
panah.pasopati.it16.com.   IN  A   192.241.2.6
www.panah.pasopati.it16.com.   IN  CNAME panah.pasopati.it16.com.

log.panah.pasopati.it16.com.   IN  A   192.241.2.6
www.log.panah.pasopati.it16.com.   IN  CNAME log.panah.pasopati.it16.com.
EOF'

# Restart BIND untuk menerapkan konfigurasi Master
sudo service bind9 restart 

# Konfigurasi DNS Slave (Majapahit)
sudo bash -c 'cat << EOF >> /etc/bind/named.conf.local
zone "it16.com" {
    type slave;
    file "/var/cache/bind/db.it16.com";
    masters { 192.241.2.4; };  # Alamat IP DNS Master
};
EOF'

# Restart BIND di Majapahit untuk menerapkan konfigurasi Slave
sudo systemctl restart bind9

# Buat direktori log untuk BIND
sudo mkdir -p /var/log/named
sudo chown bind:bind /var/log/named

# Menambahkan konfigurasi logging
logging {
    channel default_log {
        file "/var/log/named/named.log";
        severity info;
        print-time yes;
    };
    category default { default_log; };
};
EOF'

# Restart BIND untuk menerapkan konfigurasi logging
echo "Restarting BIND with logging..."
sudo service bind9 restart 
