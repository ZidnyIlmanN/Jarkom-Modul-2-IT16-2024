# Jarkom-Modul-2-IT16-2024

|Nama  | NRP |
|--|--|
| Zidny Ilman Nafi'an | 5027221072 |
| MUHAMMAD DZAKWAN	  | 5027201065 |

## Topologi
![image](https://github.com/user-attachments/assets/bbd3962d-1c5e-47fc-b400-5b4ec2e9cdfc)


## IP Addresses
| Device      | Interface | IP Address | Netmask       | Gateway     |
|-------------|-----------|------------|---------------|-------------|
| **Nusantara** | eth0      | DHCP (192.168.122.1)       |               |             |
|             | eth1      | 192.235.1.2| 255.255.255.0 |             |
|             | eth2      | 192.235.2.2| 255.255.255.0 |             |
|             | eth3      | 192.235.3.2| 255.255.255.0 |             |
| **Sriwijaya**| eth0      | 192.235.2.1| 255.255.255.0 | 192.235.2.2 |
| **Tanjungkulai**| eth0     | 192.235.3.3| 255.255.255.0 | 192.235.3.2 |
| **Bedahulu** | eth0      | 192.235.3.4| 255.255.255.0 | 192.235.3.2 |
| **Majapahit** | eth0      | 192.235.3.1| 255.255.255.0 | 192.235.3.2 |
| **Samaratungga** | eth0      | 192.235.1.1| 255.255.255.0 | 192.235.1.2 |
| **Solok**   | eth0      | 192.235.1.3| 255.255.255.0 | 192.235.1.2 |
| **Mulawarman**   | eth0      | 192.235.2.3| 255.255.255.0 | 192.235.2.2 |
| **Alexander Volta**| eth0    | 192.235.2.4| 255.255.255.0 | 192.235.2.2 |
| **Balaraja**   | eth0      | 192.235.2.5| 255.255.255.0 | 192.235.2.2 |
| **Kotalingga**| eth0    | 192.235.2.6| 255.255.255.0 | 192.235.2.2 |

# No. 1
> Untuk mempersiapkan peperangan World War MMXXIV (Iya sebanyak itu), Sriwijaya membuat dua kotanya menjadi web server yaitu Tanjungkulai, dan Bedahulu, serta Sriwijaya sendiri akan menjadi DNS Master. Kemudian karena merasa terdesak, Majapahit memberikan bantuan dan menjadikan kerajaannya (Majapahit) menjadi DNS Slave. 


On each node, configure network.


### Nusantara (Router)
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.244.1.2
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.244.2.2
	netmask 255.255.255.0
	
auto eth3
iface eth3 inet static
	address 192.244.3.2
	netmask 255.255.255.0
```

### Sriwijaya (DNS Master)
```
auto eth0
iface eth0 inet static
	address 192.235.2.1
	netmask 255.255.255.0
	gateway 192.235.2.2
```

### Majapahit (DNS Slave)
```
auto eth0
iface eth0 inet static
	address 192.235.3.1
	netmask 255.255.255.0
	gateway 192.235.3.2
```

### Tanjungkulai (Web Server)
```
auto eth0
iface eth0 inet static
	address 192.235.3.3
	netmask 255.255.255.0
	gateway 192.235.3.2
```

### Bedahulu (Web Server)
```
auto eth0
iface eth0 inet static
	address 192.235.3.4
	netmask 255.255.255.0
	gateway 192.235.3.2
```

### Kotalingga (Web Server)
```
auto eth0
iface eth0 inet static
	address 192.235.2.6
	netmask 255.255.255.0
	gateway 192.235.2.2
```

### Solok (Load Balancer)
```
auto eth0
iface eth0 inet static
	address 192.235.1.3
	netmask 255.255.255.0
	gateway 192.235.1.2
```

### Samaratungga (Client)
```
auto eth0
iface eth0 inet static
	address 192.235.1.1
	netmask 255.255.255.0
	gateway 192.235.1.2
```

### Mulawarman (Client)
```
auto eth0
iface eth0 inet static
	address 192.235.2.3
	netmask 255.255.255.0
	gateway 192.235.2.2
```

### Alexander Volta (Client)
```
auto eth0
iface eth0 inet static
	address 192.235.2.4
	netmask 255.255.255.0
	gateway 192.235.2.2
```

### Balaraja (Client)
```
auto eth0
iface eth0 inet static
	address 192.235.2.5
	netmask 255.255.255.0
	gateway 192.235.2.2
```
## Setup /root/.bashrc

- Router
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.235.0.0/16
echo nameserver 192.168.122.1 > /etc/resolv.conf
```

- DNS Master
```
echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y
```

-DNS Slave
```
echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y
```

-Client
```
echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
echo nameserver 192.235.2.1 > /etc/resolv.conf
```

## Check IP address
```
ip a
```
![image](https://github.com/user-attachments/assets/25c4fda2-1f8b-46a1-98a3-1db252afe0f4)

# No. 2
>Karena para pasukan membutuhkan koordinasi untuk melancarkan serangannya, maka buatlah sebuah domain yang mengarah ke Solok dengan alamat sudarsana.xxxx.com dengan alias www.sudarsana.xxxx.com, dimana xxxx merupakan kode kelompok. Contoh: sudarsana.it01.com

## Setup DNS @ Sriwijaya
```
echo 'zone "sudarsana.it04.com" {
    type master;
    notify yes;
	  also-notify { 192.235.3.1; };
    allow-transfer { 192.235.3.1; };
    file "/etc/bind/it04/sudarsana.it04.com";
};' >>   /etc/bind/named.conf.local

mkdir /etc/bind/it04

cp /etc/bind/db.local /etc/bind/it04/sudarsana.it04.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     sudarsana.it04.com. root.sudarsana.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      sudarsana.it04.com.
@       IN      A       192.235.1.3
@       IN      AAAA    ::1
www     IN      CNAME   sudarsana.it04.com.' > /etc/bind/it04/sudarsana.it04.com

service bind9 restart
```


# No. 3
> Para pasukan juga perlu mengetahui mana titik yang akan diserang, sehingga dibutuhkan domain lain yaitu pasopati.xxxx.com dengan alias www.pasopati.xxxx.com yang mengarah ke Kotalingga.

## Setup DNS @ Sriwijaya
```
echo 'zone "pasopati.it04.com" {
    type master;
    notify yes;
	  also-notify { 192.235.3.1; };
    allow-transfer { 192.235.3.1; };
    file "/etc/bind/it04/pasopati.it04.com";
};' >> /etc/bind/named.conf.local

mkdir /etc/bind/it04

cp /etc/bind/db.local /etc/bind/it04/pasopati.it04.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     pasopati.it04.com. root.pasopati.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      pasopati.it04.com.
@       IN      A       192.235.2.6
@       IN      AAAA    ::1
www     IN      CNAME   pasopati.it04.com.' > /etc/bind/it04/pasopati.it04.com

service bind9 restart
```

# No. 4
> Markas pusat meminta dibuatnya domain khusus untuk menaruh informasi persenjataan dan suplai yang tersebar. Informasi dan suplai meme terbaru tersebut mengarah ke Tanjungkulai dan domain yang ingin digunakan adalah rujapala.xxxx.com dengan alias www.rujapala.xxxx.com.


## Setup DNS @ Sriwijaya
```
echo 'zone "rujapala.it04.com" {
    type master;
    notify yes;
	  also-notify { 192.235.3.1; };
    allow-transfer { 192.235.3.1; };
    file "/etc/bind/it04/rujapala.it04.com";
};' >> /etc/bind/named.conf.local

mkdir /etc/bind/it04

cp /etc/bind/db.local /etc/bind/it04/rujapala.it04.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     rujapala.it04.com. root.rujapala.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      rujapala.it04.com.
@       IN      A       192.235.3.3
@       IN      AAAA    ::1
www     IN      CNAME   rujapala.it04.com.' > /etc/bind/it04/rujapala.it04.com

service bind9 restart
```

# No.5
> Pastikan domain-domain tersebut dapat diakses oleh seluruh komputer (client) yang berada di Nusantara.

![Screenshot 2024-10-02 010503](https://github.com/user-attachments/assets/7a16708f-96b8-4710-9444-e44667408261)
![Screenshot 2024-10-02 010714](https://github.com/user-attachments/assets/829628e6-06dd-456e-a1f4-0df7a994ffbf)
![Screenshot 2024-10-02 011006](https://github.com/user-attachments/assets/27b310e0-20fb-47f0-83f0-dea11adfe4ad)
![Screenshot 2024-10-02 011238](https://github.com/user-attachments/assets/684621bb-b66d-4bfc-9331-aa14dd42e77c)


# No. 6
> Beberapa daerah memiliki keterbatasan yang menyebabkan hanya dapat mengakses domain secara langsung melalui alamat IP domain tersebut. Karena daerah tersebut tidak diketahui secara spesifik, pastikan semua komputer (client) dapat mengakses domain pasopati.xxxx.com melalui alamat IP Kotalingga (Notes: menggunakan pointer record).

## Setup DNS @ Sriwijaya
```
echo 'zone "2.235.192.in-addr.arpa" {
    type master;
    file "/etc/bind/it04/2.235.192.in-addr.arpa";
};' >> /etc/bind/named.conf.local

mkdir /etc/bind/it04

cp /etc/bind/db.local /etc/bind/it04/2.235.192.in-addr.arpa

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     pasopati.it04.com. root.pasopati.it04.com (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
2.235.192.in-addr.arpa.      IN      NS      pasopati.it04.com.
6                            IN      PTR     pasopati.it04.com.' > /etc/bind/it04/2.235.192.in-addr.arpa

service bind9 restart
```
![image](https://github.com/user-attachments/assets/40772d64-62bc-49fe-af6b-25158a8fdfe8)
![image](https://github.com/user-attachments/assets/cb07eab6-fde7-4320-9e93-d49c897309d2)
![image](https://github.com/user-attachments/assets/3d5c4efd-5fbc-4c5e-951f-517893ad8e13)
![image](https://github.com/user-attachments/assets/f64bd815-7b86-4c19-bb4f-e4e1d7cc0243)

# No. 7
> Akhir-akhir ini seringkali terjadi serangan brainrot ke DNS Server Utama, sebagai tindakan antisipasi kamu diperintahkan untuk membuat DNS Slave di Majapahit untuk semua domain yang sudah dibuat sebelumnya yang mengarah ke Sriwijaya.

## Setup DNS @ Majapahit
```
echo 'zone "sudarsana.it04.com" {
    type slave;
    masters { 192.235.2.1; };
    file "/var/lib/bind/sudarsana.it04.com";
};

zone "pasopati.it04.com" {
    type slave;
    masters { 192.235.2.1; };
    file "/var/lib/bind/pasopati.it04.com";
};

zone "rujapala.it04.com" {
    type slave;
    masters { 192.235.2.1; };
    file "/var/lib/bind/rujapala.it04.com";
};' > /etc/bind/named.conf.local

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     sudarsana.it04.com. root.sudarsana.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      sudarsana.it04.com.
@       IN      A       192.235.2.1
@       IN      AAAA    ::1
www     IN      CNAME   sudarsana.it04.com.' > /var/lib/bind/sudarsana.it04.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     pasopati.it04.com. root.pasopati.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      pasopati.it04.com.
@       IN      A       192.235.2.1
@       IN      AAAA    ::1
www     IN      CNAME   pasopati.it04.com.' > /var/lib/bind/pasopati.it04.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     rujapala.it04.com. root.rujapala.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      rujapala.it04.com.
@       IN      A       192.235.2.1
@       IN      AAAA    ::1
www     IN      CNAME   rujapala.it04.com.' > /var/lib/bind/rujapala.it04.com

# Restart BIND9 service to apply changes
service bind9 restart
```
![image](https://github.com/user-attachments/assets/f99a0b66-e2dc-498d-bc70-2185c9a27a4c)
![image](https://github.com/user-attachments/assets/2beabc06-6aab-423b-9fa0-9187e366e15d)
![image](https://github.com/user-attachments/assets/e29923cc-f2de-439d-b310-64a2d113f3c4)
![image](https://github.com/user-attachments/assets/99e52deb-0ac8-45a2-9095-4fb965b182b5)


# No. 8
> Kamu juga diperintahkan untuk membuat subdomain khusus melacak kekuatan tersembunyi di Ohio dengan subdomain cakra.sudarsana.xxxx.com yang mengarah ke Bedahulu.

## Setup DNS @ Sriwijaya
```
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     sudarsana.it04.com. root.sudarsana.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      sudarsana.it04.com.
@       IN      A       192.235.1.3
cakra   IN      A       192.235.3.4
@       IN      AAAA    ::1
www     IN      CNAME   sudarsana.it04.com.' > /etc/bind/it04/sudarsana.it04.com

service bind9 restart
```
![image](https://github.com/user-attachments/assets/f75c1ed6-b821-42e1-b7fe-9e42540aff9c)
![image](https://github.com/user-attachments/assets/556ea38c-ca05-4ed1-b23a-f93a66d1923f)
![image](https://github.com/user-attachments/assets/8fc341e2-d0db-498d-bd0f-905aabcaeb71)
![image](https://github.com/user-attachments/assets/b484e3eb-2d5a-4b12-9e60-6606b395b718)


# No. 9
> Karena terjadi serangan DDOS oleh shikanoko nokonoko koshitantan (NUN), sehingga sistem komunikasinya terhalang. Untuk melindungi warga, kita diperlukan untuk membuat sistem peringatan dari siren man oleh Frekuensi Freak dan memasukkannya ke subdomain panah.pasopati.xxxx.com dalam folder panah dan pastikan dapat diakses secara mudah dengan menambahkan alias www.panah.pasopati.xxxx.com dan mendelegasikan subdomain tersebut ke Majapahit dengan alamat IP menuju radar di Kotalingga.

## Setup DNS @ Sriwijaya
```
echo '
options {
  directory "var/cache/bind";
  allow-query {any;};
  auth-nxdomain no;
  listen-on-v6 {any;}
};' > /etc/bind/named.conf.options

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     pasopati.it04.com. root.pasopati.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      pasopati.it04.com.
@       IN      A       192.235.2.6
@       IN      AAAA    ::1
www     IN      CNAME   pasopati.it04.com.
kotalingga  IN  A       192.235.2.6
ns1     IN      A       192.235.3.1
panah   IN      NS      ns1' > /etc/bind/it04/pasopati.it04.com

service bind9 restart
```
## Setup DNS @ Majapahit
```
echo '
options {
  directory "var/cache/bind";
  allow-query {any;};
  auth-nxdomain no;
  listen-on-v6 {any;};
};' > /etc/bind/named.conf.options

echo '
zone "panah.pasopati.it04.com"{
  type master;
  file "/etc/bind/it04/panah.pasopati.it04.com";
  };' >> /etc/bind/named.conf.local

mkdir /etc/bind/it04
cp /etc/bind/db.local /etc/bind/it04/panah.pasopati.it04.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     panah.pasopati.it04.com. root.panah.pasopati.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      panah.pasopati.it04.com.
@       IN      A       192.235.3.1
@       IN      AAAA    ::1
www     IN      CNAME   panah.pasopati.it04.com.' > /etc/bind/it04/panah.pasopati.it04.com

service bind9 restart
```
![image](https://github.com/user-attachments/assets/6f36c10f-eeaa-4f62-a8f8-536f9480e689)
![image](https://github.com/user-attachments/assets/78bb4101-01ed-428d-ad17-7581cbc0b0c7)
![image](https://github.com/user-attachments/assets/789eabd2-6914-423d-94fa-31ad861d2f2e)
![image](https://github.com/user-attachments/assets/ea0191af-67c1-4f5e-9cff-61e2375ba0ac)

# No. 10
> Markas juga meminta catatan kapan saja meme brain rot akan dijatuhkan, maka buatlah subdomain baru di subdomain panah yaitu log.panah.pasopati.xxxx.com serta aliasnya www.log.panah.pasopati.xxxx.com yang juga mengarah ke Kotalingga.
## Setup DNS @ Sriwijaya
```
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     pasopati.it04.com. root.pasopati.it04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      pasopati.it04.com.
@       IN      A       192.235.2.6
@       IN      AAAA    ::1
www     IN      CNAME   pasopati.it04.com.
kotalingga  IN  A       192.235.2.6
log.panah IN    A       192.235.2.6
www.log.panah   IN    CNAME   log.panah.pasopati.it04.com.' > /etc/bind/it04/pasopati.it04.com

service bind9 restart
```
![image](https://github.com/user-attachments/assets/bbbb8e25-2f7a-46d0-988b-0a3f8becb569)
![image](https://github.com/user-attachments/assets/cc722ecf-2cc3-4f18-8a89-48d15e064474)
![image](https://github.com/user-attachments/assets/22fef1ee-9266-49a8-9a0b-d8b9e4754d69)
![image](https://github.com/user-attachments/assets/1c684c3a-935a-4ffc-a04d-aa42b147dbb9)

# No. 11
> Setelah pertempuran mereda, warga IT dapat kembali mengakses jaringan luar dan menikmati meme brainrot terbaru, tetapi hanya warga Majapahit saja yang dapat mengakses jaringan luar secara langsung. Buatlah konfigurasi agar warga IT yang berada diluar Majapahit dapat mengakses jaringan luar melalui DNS Server Majapahit.
## Setup DNS @ Sriwijaya
```
echo ' options {
        directory "/var/cache/bind";

        forwarders {
                192.168.122.1;
        };
        allow-query { any; };
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
}; ' > /etc/bind/named.conf.options

service bind9 restart
```

# No.12
> Karena pusat ingin sebuah laman web yang ingin digunakan untuk memantau kondisi kota lainnya maka deploy laman web ini (cek resource yg lb) pada Kotalingga menggunakan apache.
## Script Kotalingga
```
(Kotalingga)
#!/bin/bash

if ! command -v named &> /dev/null
then
    echo "Apache2 belum terinstal, melakukan instalasi..."
    # Instalasi apache2
    apt-get update
    apt-get install apache2 -y
    apt-get install libapache2-mod-php7.0 -y
else
    echo "apache2 sudah terinstal."
fi

if ! command -v named &> /dev/null
then
    echo "Unzip belum terinstal, melakukan instalasi..."
    # Instalasi unzip
    apt-get update
    apt-get install unzip -y
else
    echo "unzip sudah terinstal."
fi

if ! command -v named &> /dev/null
then
    echo "PHP belum terinstal, melakukan instalasi..."
    # Melakukan instalasi php
    apt-get update
    apt-get install php -y
else
    echo "php sudah terinstal."
fi

curl -L -o lb.zip --insecure "https://drive.google.com/uc?export=download&id=1Sqf0TIiybYyUp5nyab4twy9svkgq8bi7"

unzip lb.zip

rm -rf /var/www/html/index.php

cp worker/index.php /var/www/html/index.php

service apache2 restart
```
Script Master dan Slave ( Sriwijaya & Majapahit )
```
#!/bin/bash

# tambahkan nameserver IP Kotalingga
echo '
nameserver 192.168.122.1
nameserver 192.235.2.6' > /etc/resolv.conf
```
Script Client
```
#!/bin/bash

if ! command -v named &> /dev/null
then
    echo "Lynx belum terinstal, melakukan instalasi..."
    # Instalasi lynx
    apt-get update
    apt-get install lynx -y
else
    echo "lynx sudah terinstal."
fi
```
Mulawarman
![Screenshot 2024-10-03 230739](https://github.com/user-attachments/assets/8969824f-9c27-4aea-90c8-5edd2ce99803)
Samaratungga
![Screenshot 2024-10-03 231205](https://github.com/user-attachments/assets/930671e2-2da9-404d-a4b0-b2fecb6647d2)
Alexandervolta
![Screenshot 2024-10-03 232009](https://github.com/user-attachments/assets/997566bc-2d30-4fd7-8368-551ef99b2e48)
Balaraja
![Screenshot 2024-10-03 232105](https://github.com/user-attachments/assets/ccab7f60-323c-47c7-87a4-c9f6b22dcddb)


# No.13
> Karena Sriwijaya dan Majapahit memenangkan pertempuran ini dan memiliki banyak uang dari hasil penjarahan (sebanyak 35 juta, belum dipotong pajak) maka pusat meminta kita memasang load balancer untuk membagikan uangnya pada web nya, dengan Kotalingga, Bedahulu, Tanjungkulai sebagai worker dan Solok sebagai Load Balancer menggunakan apache sebagai web server nya dan load balancer nya.
## Script @ Solok
```
#!/bin/bash

if ! command -v named &> /dev/null
then
    echo "Apache2 belum terinstal, melakukan instalasi..."
    # Instalasi apache2
    apt-get update
    apt-get install apache2 -y
    apt-get install libapache2-mod-php7.0 -y
else
    echo "apache2 sudah terinstal."
fi

if ! command -v named &> /dev/null
then
    echo "PHP belum terinstal, melakukan instalasi..."
    # Melakukan instalasi php
    apt-get update
    apt-get install php -y
else
    echo "php sudah terinstal."
fi

# Enable apache2 module
a2enmod proxy_balancer
a2enmod proxy_http
a2enmod lbmethod_byrequests
echo '
<VirtualHost *:80>
    <Proxy balancer://serverpool>
        BalancerMember http://192.235.3.3/
        BalancerMember http://192.235.3.4/
        BalancerMember http://192.235.3.6/
        Proxyset lbmethod=byrequests
    </Proxy>
    ProxyPass / balancer://serverpool/
    ProxyPassReverse / balancer://serverpool/
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

service apache2 restart
```

https://github.com/user-attachments/assets/a00e931d-3058-4d88-bde5-69d2577b35e9



# No.14
> Selama melakukan penjarahan mereka melihat bagaimana web server luar negeri, hal ini membuat mereka iri, dengki, sirik dan ingin flexing sehingga meminta agar web server dan load balancer nya diubah menjadi nginx.
## Script @ Kotalingga, Bedahulu, Tanjungkulai
```
apt-get install nginx php-fpm -y

mkdir /var/www/pasopati.it04.com

echo " <?php
\$hostname = gethostname();
\$date = date('Y-m-d H:i:s');
\$php_version = phpversion();
\$username = get_current_user();

echo \"Hello World!<br\>\";
echo \"Saya adalah: \$username<br\>\";
echo \"Saat ini berada di: \$hostname<br\>\";
echo \"Versi PHP yang saya gunakan: \$php_version<br\>\";
echo \"Tanggal saat ini: \$date<b\r\>\";
?>" > /var/www/pasopati.it04.com/index.php

echo '
 server {

        listen 80;

        root /var/www/pasopati.it04.com;

        index index.php index.html index.htm;
        server_name _;

        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }

        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        }

        location ~ /\.ht {
                        deny all;
        }

        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 } ' > /etc/nginx/sites-available/pasopati.it04.com

ln -s /etc/nginx/sites-available/pasopati.it04.com /etc/nginx/sites-enabled/pasopati.it04.com
rm -rf /etc/nginx/sites-enabled/default

service nginx restart
service php7.0-fpm stop
service php7.0-fpm start
```
## Script @ Solok
```
apt-get install nginx -y

echo ' # Default menggunakan Round Robin
 upstream webserver  {
       server 192.235.2.6;
       server 192.235.3.3;
       server 192.235.3.4;
 }

 server {
        listen 80;
        server_name _;

        location / {
        proxy_pass http://webserver;
        }
 }' > /etc/nginx/sites-available/solok

ln -s /etc/nginx/sites-available/solok /etc/nginx/sites-enabled/solok

rm -rf /etc/nginx/sites-enabled/default

service nginx restart
```
![image](https://github.com/user-attachments/assets/033f9ba5-8a5b-4593-a39a-4256593908d8)
![image](https://github.com/user-attachments/assets/2b4641f9-289a-4b5e-af91-0adf4fa53ca0)
![image](https://github.com/user-attachments/assets/cae3244e-2edf-4b1c-8c6d-d849bb5aee16)
