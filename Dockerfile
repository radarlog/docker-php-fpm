FROM alpine:3.7

MAINTAINER Ilian Ranguelov <me@radarlog.net>

# install php7 and some extensions
RUN apk --no-cache add --update php7 php7-fpm \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-ftp \
    php7-gd php7-imagick \
    php7-json \
    php7-iconv \
    php7-mbstring \
    php7-opcache \
    php7-pdo php7-pdo_mysql php7-mysqli php7-pdo_sqlite \
    php7-session \
    php7-tokenizer \
    php7-xml php7-simplexml php7-xmlreader php7-xmlwriter \
    php7-xdebug \
    php7-zip \
    && rm -rf /var/cache/apk/*

# set some default directives
ENV PHP_DISPLAY_ERRORS 0
ENV PHP_EXPOSE 0
ENV PHP_LOG_ERRORS 1
ENV PHP_POST_MAX_SIZE 1G
ENV PHP_SENDMAIL_PATH /usr/sbin/sendmail -t -i
ENV PHP_UPLOAD_MAX_FILESIZE 1G

ENV PHP_OPCACHE_ENABLE 1
ENV PHP_OPCACHE_ENABLE_CLI 1
ENV PHP_OPCACHE_FAST_SHUTDOWN 1
ENV PHP_OPCACHE_INTERNED_STRINGS_BUFFER 8
ENV PHP_OPCACHE_MEMORY_CONSUMPTION 128
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES 5000
ENV PHP_OPCACHE_REVALIDATE_FREQ 2
ENV PHP_OPCACHE_SAVE_COMMENTS 1

COPY php.ini /etc/php7/
COPY fpm.conf /etc/php7/php-fpm.d/zz-docker.conf

WORKDIR /var/www/html

COPY entrypoint-php.sh /usr/local/bin/

EXPOSE 9000

ENTRYPOINT ["entrypoint-php.sh"]
CMD ["php-fpm7"]
