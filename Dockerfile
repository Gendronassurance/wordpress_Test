# You can change this to a different version of Wordpress available at
# https://hub.docker.com/_/wordpress
# Use a newer version of WordPress with PHP 8.2
FROM wordpress:6.5.2-php8.2-apache

RUN apt-get update && apt-get install -y \
    apache2-utils \
    magic-wormhole

RUN usermod -s /bin/bash www-data
RUN chown www-data:www-data /var/www

# Copy custom php.ini into PHP config directory
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Copy .htpasswd into the image
COPY .htpasswd /etc/apache2/.htpasswd


# Enable Apache modules
RUN a2enmod auth_basic

# Add Basic Auth config to Apache
RUN echo '<Directory "/var/www/html">' >> /etc/apache2/apache2.conf && \
    echo '  AuthType Basic' >> /etc/apache2/apache2.conf && \
    echo '  AuthName "Restricted Access"' >> /etc/apache2/apache2.conf && \
    echo '  AuthUserFile /etc/apache2/.htpasswd' >> /etc/apache2/apache2.conf && \
    echo '  Require valid-user' >> /etc/apache2/apache2.conf && \
    echo '</Directory>' >> /etc/apache2/apache2.conf


USER www-data:www-data
