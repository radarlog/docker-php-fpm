FROM php:7.1-fpm-alpine

MAINTAINER Ilian Ranguelov <me@radarlog.net>

# Build xdebug extension
RUN apk --no-cache add --update --virtual build-dependencies g++ make autoconf \
    && pecl install xdebug && docker-php-ext-enable xdebug \
    && apk del build-dependencies \
    && rm -rf /tmp/* /var/cache/apk/*

COPY entrypoint.sh /bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["entrypoint.sh"]
CMD ["php-fpm"]
