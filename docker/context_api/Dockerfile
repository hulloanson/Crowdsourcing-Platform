FROM php:7.3.1-apache

COPY scripts /scripts

RUN /scripts/install-composer.sh

RUN apt-get update

RUN apt-get install git -y

RUN docker-php-ext-install pdo_mysql

RUN apt-get install zlib1g zlib1g-dev libzip4 libzip-dev unzip libwebp-dev libjpeg-dev libpng-dev -y

RUN docker-php-ext-install zip

RUN docker-php-ext-install gd

RUN a2enmod rewrite

RUN a2enmod headers

ARG rungid

ENV rungid ${rungid:-1000}

ARG runuid

ENV runuid ${runuid:-1000}

RUN echo $runuid

RUN addgroup --gid $rungid thegroup; true

RUN adduser --disabled-password --gecos "" --ingroup thegroup --uid $runuid theuser

VOLUME [ "/var/www/html" ]

RUN chown -R theuser /var/www/html

RUN sed -iE -e 's/^.*APACHE_RUN_USER.*$//g' /etc/apache2/envvars

RUN sed -iE -e 's/^.*APACHE_RUN_GROUP.*$//g' /etc/apache2/envvars

RUN echo 'export APACHE_RUN_USER=theuser' >> /etc/apache2/envvars

RUN echo 'export APACHE_RUN_GROUP=thegroup' >> /etc/apache2/envvars

COPY 000-default.conf /etc/apache2/sites-available
