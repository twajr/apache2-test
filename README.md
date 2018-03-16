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

### Dockerfile
```
FROM httpd:2.4
COPY ./index.html /usr/local/apache2/htdocs/
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
```
