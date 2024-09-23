# Используем официальный образ PHP с Apache
FROM php:8.3.11-apache

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y git libpng-dev libjpeg-dev libfreetype6-dev default-mysql-client\
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql

# Включаем модуль rewrite Apache
RUN a2enmod rewrite

# Клонируем проект из git-репозитория
RUN git clone https://github.com/sunflower-sms/openSIS-Classic /var/www/html/ \
    && chown -R www-data:www-data /var/www/html/
