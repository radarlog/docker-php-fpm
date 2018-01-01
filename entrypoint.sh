#!/bin/sh
set -e

PHP_CONF_DIR=/usr/local/etc/php/conf.d

# handle xdebug
cat > ${PHP_CONF_DIR}/xdebug.ini << END_OF_XDEBUG_CONF
xdebug.remote_enable=${XDEBUG_ENABLED:-0}
xdebug.remote_autostart=0
END_OF_XDEBUG_CONF

exec $@
