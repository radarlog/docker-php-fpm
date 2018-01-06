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
    php7-pdo php7-pdo_mysql php7-pdo_sqlite \
    php7-session \
    php7-tokenizer \
    php7-xml php7-simplexml php7-xmlreader php7-xmlwriter \
    php7-xdebug \
    php7-zip \
    && rm -rf /var/cache/apk/*

# init setup
RUN set -ex \
	&& cd /etc/php7 \
	&& { \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo; \
		echo '[www]'; \
		echo 'listen = [::]:9000'; \
		echo '; if we send this to /proc/self/fd/1, it never appears'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo; \
		echo 'clear_env = no'; \
		echo; \
		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
		echo 'catch_workers_output = yes'; \
	} | tee php-fpm.d/zz-docker.conf

COPY entrypoint-php.sh /usr/local/bin/

EXPOSE 9000

ENTRYPOINT ["entrypoint-php.sh"]
CMD ["php-fpm7"]
