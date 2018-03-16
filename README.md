# apache2-test

This project demonstrates using the basic docker httpd image to create test scenarios. Basic HTML pages as well as the httpd.conf files are passed via the Dockerfile. This creates a simple docker image for testing various apache2 configurations. 

### Apache Config Items

Apached listens on port 8080 as this project is used as a 'backend' for the varnish-cache solution, which is also integrated as a docker instance. 
```
#
# Listen: Allows you to bind Apache to specific IP addresses and/or
# ports, instead of the default. See also the <VirtualHost>
# directive.
Listen 8080
```
Check for a specific host: header in the request, and fail with a 404 if it's not there.
```
RewriteEngine On
RewriteCond %{HTTP_HOST} !^(example.nitc\.)?162.79.27.219.xip\.io$ [NC]
RewriteRule ^(.*)$ - [L,R=404]
```
Turn logging up pretty high so I can review headers as part of the project. Notice the 'Host' item to log the host header in the access logs. 
```
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" \"%{Host}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common

    <IfModule logio_module>
      # You need to enable mod_logio.c to use %I and %O
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\ \"%{Host}i\" %I %O" combinedio
    </IfModule>

    CustomLog "/var/log/apache_access.log" common
    CustomLog "/var/log/apache_combined_access.log" combined
    CustomLog "/var/log/apache_combinedio_access.log" combinedio
</IfModule>
```
### Dockerfile
```
FROM httpd:2.4
COPY ./index.html /usr/local/apache2/htdocs/
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
EXPOSE 8080
```
