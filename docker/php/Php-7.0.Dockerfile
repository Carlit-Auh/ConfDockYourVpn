# see https://github.com/cmaessen/docker-php-sendmail for more information

FROM php:7.0-fpm

ENV APP_ENV=dev

RUN apt-get update && apt-get install -q -y ssmtp mailutils git iproute2 zip unzip libpq-dev libxml2-dev \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) iconv mcrypt \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

RUN docker-php-ext-install \
    pdo_pgsql pgsql \
    soap zip

COPY ./development.ini /usr/local/etc/php/conf.d/development.ini

# composer install
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN echo "hostname=localhost.localdomain" > /etc/ssmtp/ssmtp.conf
RUN echo "root=root@example.com" >> /etc/ssmtp/ssmtp.conf
RUN echo "mailhub=maildev" >> /etc/ssmtp/ssmtp.conf

RUN echo "sendmail_path=sendmail -i -t" >> /usr/local/etc/php/conf.d/php-sendmail.ini

RUN echo "localhost localhost.localdomain" >> /etc/hosts

RUN mkdir -p /var/www/html/vendor
RUN mkdir -p /var/www/html/app/cache
RUN mkdir -p /var/www/html/.composer

RUN chown -R www-data:www-data /var/www/html/vendor
RUN chown -R www-data:www-data /var/www/html/app/cache
RUN chown -R www-data:www-data /var/www/html/.composer

RUN mkdir -p /tmp/sessions
RUN chmod 777 /tmp/sessions
USER www-data
