#!/bin/sh
set -e

PHP_CONF_DIR=/etc/php83/conf.d

# handle xdebug
[ ${XDEBUG_MODE} == 'debug' ] && { \
    echo 'zend_extension=xdebug.so'; \
    echo 'xdebug.mode=off'; \
} | tee ${PHP_CONF_DIR}/xdebug.ini > /dev/null

exec $@
