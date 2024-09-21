# Используем официальный образ PHP с Apache
FROM php:8.3.11-apache

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y git libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql

# Включаем модуль rewrite Apache
RUN a2enmod rewrite

# Включаем отображение ошибок в консоль (stdout)
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-errors.ini \
    && echo "display_errors = Off" >> /usr/local/etc/php/conf.d/docker-php-errors.ini \
    && echo "log_errors = On" >> /usr/local/etc/php/conf.d/docker-php-errors.ini \
    && echo "error_log = /dev/stdout" >> /usr/local/etc/php/conf.d/docker-php-errors.ini

# Клонируем проект из git-репозитория
RUN git clone https://github.com/sunflower-sms/openSIS-Classic /var/www/html/

# Устанавливаем права на директорию
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/