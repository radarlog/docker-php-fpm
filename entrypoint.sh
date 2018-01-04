#!/bin/sh
set -e

PHP_CONF_DIR=/etc/php7/conf.d

# handle xdebug
[ ${XDEBUG_ENABLED:-0} == 1 ] && { \
    echo 'zend_extension=xdebug.so'; \
    echo 'xdebug.remote_enable=1'; \
    echo 'xdebug.remote_autostart=0'; \
} | tee ${PHP_CONF_DIR}/xdebug.ini > /dev/null

exec $@
