
```bash
sudo apt update && sudo apt install -y nginx
sudo usermod -a -G iadfeshchm www-data # Добавляет www-data в группу iadfeshchm
groups www-data # Проверяем группы www-data
sudo -u www-data stat /home/iadfeshchm/projects/my/lab # Проверяем доступ www-data к проекту в iadfeshchm (chmod g+x /home/  chmod g+x /home/username)
sudo rm /etc/nginx/sites-enabled/default

# /etc/nginx/nginx.conf
include /etc/nginx/sites-enabled/*.conf; # Вместо include /etc/nginx/sites-enabled/*;

sudo nginx -t
sudo nginx -s reload
sudo systemctl restart nginx
systemctl status nginx
openhosts
```
