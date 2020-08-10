#!/bin/sh
# make sure symlinks are intact after volumes have been mounted
vendor/bin/contao-console contao:symlinks
# Clear the contao cache before runtime startup and after volumes have
# been mounted
vendor/bin/contao-console cache:clear
# make sure permissions are set
chown -R www-data: /application

# Start the PHP-FPM process
php-fpm
status=$?
if [ $status -ne 0 ]; then
    echo "Failed to start php-fpm: $status"
    exit $status
fi
