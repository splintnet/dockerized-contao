###############################################################################
# Nginx
###############################################################################

FROM nginx:alpine as nginx
LABEL maintainer="j.imping@5-anker.com"

WORKDIR /application

COPY docker/config/nginx.conf /etc/nginx/conf.d/default.conf


###############################################################################
# PHP
###############################################################################

FROM registry.5-anker.com/5anker/docker-base/php:latest as contao
LABEL maintainer="j.imping@5-anker.com"

WORKDIR /application

COPY --chown=www-data:www-data composer.phar composer.json composer.lock ./
COPY --chown=www-data:www-data bundles ./bundles

COPY docker/config/php.ini /usr/local/etc/php/conf.d/docker.ini


RUN chown www-data:www-data .
USER www-data
RUN php composer.phar install --no-scripts --no-autoloader --no-dev

COPY --chown=www-data:www-data . .
COPY --chown=www-data:www-data .env.example .env

RUN php composer.phar dump-autoload && php composer.phar run-script post-install-cmd
