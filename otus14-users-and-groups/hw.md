### Запретить всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников
1. Create test user and group
```bash
sudo useradd testuser
sudo groupadd admin
echo "Otus2019"|sudo passwd --stdin testuser
sudo usermod -G admin testuser
```
2. Place is-admin.sh  to the /usr/local/bin/
3. Make the following changes  to /etc/pam.d/sshd 
```bash
...
account required pam_nologin.so
account required pam_exec.so /usr/local/bin/is-admin.sh # <- this is a change
...
```
4. Make test from another console. DO NOT exit from the current console untill tested properly

