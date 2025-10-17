FROM alpine:3.22

LABEL maintainer="Ilian Ranguelov <me@radarlog.net>"

# install php83 and some extensions
RUN apk --no-cache add --update php83 php83-fpm \
    php83-ctype \
    php83-curl \
    php83-dom \
    php83-ftp \
    php83-gd php83-pecl-imagick \
    php83-iconv \
    php83-mbstring \
    php83-opcache \
    php83-pdo php83-pdo_mysql php83-mysqli php83-pdo_sqlite \
    php83-session \
    php83-tokenizer \
    php83-xml php83-simplexml php83-xmlreader php83-xmlwriter \
    php83-xdebug \
    php83-zip \
    && rm -rf /var/cache/apk/*

# set some default directives
ENV PHP_DISPLAY_ERRORS 0
ENV PHP_EXPOSE 0
ENV PHP_LOG_ERRORS 1
ENV PHP_POST_MAX_SIZE 1G
ENV PHP_SENDMAIL_PATH /usr/sbin/sendmail -t -i
ENV PHP_UPLOAD_MAX_FILESIZE 1G
ENV PHP_MEMORY_LIMIT 128M

ENV PHP_OPCACHE_ENABLE 1
ENV PHP_OPCACHE_ENABLE_CLI 1
ENV PHP_OPCACHE_FAST_SHUTDOWN 1
ENV PHP_OPCACHE_INTERNED_STRINGS_BUFFER 8
ENV PHP_OPCACHE_MEMORY_CONSUMPTION 128
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES 5000
ENV PHP_OPCACHE_REVALIDATE_FREQ 2
ENV PHP_OPCACHE_SAVE_COMMENTS 1

COPY php.ini /etc/php83/
COPY fpm.conf /etc/php83/php-fpm.d/zz-docker.conf

WORKDIR /var/www/html

COPY entrypoint-php.sh /usr/local/bin/

EXPOSE 9000

ENTRYPOINT ["entrypoint-php.sh"]
CMD ["php-fpm83"]
