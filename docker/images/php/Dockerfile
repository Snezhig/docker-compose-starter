ARG php_version=7.2
FROM php:${php_version}-fpm as base

MAINTAINER snezhig

WORKDIR /var/www

RUN apt-get update && apt-get install -y curl wget
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
RUN docker-php-ext-install pdo pdo_mysql mysqli

RUN usermod -u 1000 www-data

COPY php-starter.sh /tmp/


#region SSH
ARG set_up_ssh_server=false
ENV SET_UP_SSH_SERVER $set_up_ssh_server


RUN if [ "$set_up_ssh_server" = "true" ]; \
    then apt update && apt install -y openssh-server supervisor \
    && mkdir /var/run/sshd \
    && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && echo 'root:root' | chpasswd; fi

COPY supervisor.conf /etc/supervisor/conf.d/
#endregion

RUN rm -rf /var/lib/apt/lists/*
EXPOSE 9000 22

FROM base as php-7
RUN pecl install xdebug
COPY conf.d/                        $PHP_INI_DIR/conf.d/
CMD sh /tpm/php-starter.sh