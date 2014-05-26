<VirtualHost *:80>
  ServerAdmin admin@example.com
  ServerName example.com
  ServerAlias www.example.com
  DocumentRoot /srv/www/example.com/public_html/
  ErrorLog /srv/www/example.com/logs/error.log
  CustomLog /srv/www/example.com/logs/access.log combined
</VirtualHost>