FROM splintnet/alpine-php:latest

# Copy our contao files into the container
COPY app /application/app
COPY config /application/config
COPY contao /application/contao
COPY src /application/src
COPY [".env", "composer.json", "composer.lock", "/application/"]
# add our startup script
COPY bootstrap.sh /

# make the startup script executable
RUN chmod +x /bootstrap.sh
# run composer install on container build
RUN cd /application && composer install

# set default values for environment variables
ENV SITE_ADDRESS=localhost
ENV DEVMODE='False'

# Register volumes
VOLUME [ "/application", "/application/files", "/application/var/logs", "/application/assets" ]

# Set boostrap.sh as entrypoint
CMD ["/bootstrap.sh"]
