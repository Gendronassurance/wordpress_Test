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

USER www-data:www-data
