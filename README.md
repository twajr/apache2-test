# apache2-test

This project demonstrates using the basic docker httpd image to create test scenarios. Basic HTML pages as well as the httpd.conf files are passed via the Dockerfile. This creates a simple docker image for testing various apache2 configurations. 

### Dockerfile
```
FROM httpd:2.4
COPY ./index.html /usr/local/apache2/htdocs/
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
```
