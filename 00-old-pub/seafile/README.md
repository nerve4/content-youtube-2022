# Seafile linux install cheatsheet

```
############### DB Setup (mariadb) ###############

$ sudo mysql_secure_installation

Enter current password for root (enter for none): 	Press Enter
Set root password? [Y/n] 					Y
Remove anonymous users? [Y/n] 				Y
Disallow root login remotely? [Y/n] 			Y
Remove test database and access to it? [Y/n] 	Y  
Reload privilege tables now? [Y/n] 			Y

$ sudo mysql -u root -p

sudo mysql -u root -p

create database `ccnet-db` character set = 'utf8';
create database `seafile-db` character set = 'utf8';
create database `seahub-db` character set = 'utf8';

create user 'seafile'@'localhost' identified by 'Password123';

GRANT ALL PRIVILEGES ON `ccnet-db`.* to `seafile`@localhost;
GRANT ALL PRIVILEGES ON `seafile-db`.* to `seafile`@localhost;
GRANT ALL PRIVILEGES ON `seahub-db`.* to `seafile`@localhost;
FLUSH PRIVILEGES;
exit

############### Seafile Setup ###############

$ sudo wget O /var/eafile-server_7.1.5_x86-64.tar.gz https://s3.eu-central-1.amazonaws.com/download.seadrive.org/seafile-server_7.1.5_x86-64.tar.gz

$ sudo tar xzvf seafile-server_7.1.5_x86-64.tar.gz -C /opt

$ sudo rm -rf /opt/seafile-server_7.1.5_x86-64.tar.gz

$ sudo chown -R seafile:seafile /opt/seafile-server-7.1.5

$ cd /opt/seafile-server-7.1.5/

$ sudo ./setup-seafile-mysql.sh

-----------------------------------------------------------------
This script will guide you to setup your seafile server using MySQL.
Make sure you have read seafile server manual at

        https://download.seafile.com/published/seafile-manual/home.md

Press ENTER to continue


$ sudo chown -R seafile:seafile /opt/seafile-server-latest
$ sudo chown -R seafile:seafile /opt/seafile-data
$ sudo chown -R seafile:seafile /opt/ccnet
$ sudo chown -R seafile:seafile /opt/seahub-data
$ sudo chown -R seafile:seafile /opt/conf
$ sudo mkdir /opt/logs
$ sudo chown -R seafile:seafile /opt/logs
$ sudo mkdir /opt/pids
$ sudo chown -R seafile:seafile /opt/pids

$ sudo su - seafile
$ cd /opt/seafile-server-latest

$ ./seafile.sh start
$ ./seahub.sh start


############### Configure Nginx as a Reverse-Proxy ###############


$ sudo vi /etc/nginx/conf.d/seafile.conf

server {
    listen 80;
    listen [::]:80;
    server_name  SERVERADDRESS;
    autoindex off;
    client_max_body_size 100M;
    access_log /var/log/nginx/seafile.com.access.log;
    error_log /var/log/nginx/seafile.com.error.log;

     location / {
            proxy_pass         http://127.0.0.1:8000;
            proxy_set_header   Host $host;
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Host $server_name;
            proxy_read_timeout  1200s;
        }

     location /seafhttp {
            rewrite ^/seafhttp(.*)$ $1 break;
            proxy_pass http://127.0.0.1:8082;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_connect_timeout  36000s;
            proxy_read_timeout  36000s;
            proxy_send_timeout  36000s;
            send_timeout  36000s;
        }

    location /media {
            root /opt/seafile-server-latest/seahub;
        }
}
```