FROM splintnet/alpine-php:latest

# Copy our contao files into the container
COPY app /application/app
COPY config /application/config
COPY contao /application/contao
COPY src /application/src
COPY .env.example /application/.env
COPY ["composer.json", "composer.lock", "/application/"]
# add our startup script
COPY bootstrap.sh /

# make the startup script executable
RUN chmod +x /bootstrap.sh
# run composer install on container build
RUN cd /application && composer install && rm /application/.env

# Link the console cmd
RUN ln -s /application/vendor/bin/contao-console /usr/bin/contao

# Install Contao Manager
RUN curl -o /application/web/contao-manager.phar.php -L https://download.contao.org/contao-manager.phar

# Register volumes
VOLUME [ "/application", "/application/files", "/application/var/logs", "/application/assets" ]

# Set boostrap.sh as entrypoint
CMD ["/bootstrap.sh"]
