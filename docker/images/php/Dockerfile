ARG php_version
FROM php:${php_version}-fpm

MAINTAINER snezhig

WORKDIR /var/www

RUN usermod -u 1000 www-data

COPY php-starter.sh /tmp/

#region SSH
ARG set_up_ssh_server=false
ENV SET_UP_SSH_SERVER $set_up_ssh_server


RUN if [ "$set_up_ssh_server" = "true" ]; then apt update && apt install -y openssh-server supervisor \
    && mkdir /var/run/sshd \
    && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && echo 'root:root' | chpasswd; fi

COPY supervisor.conf /etc/supervisor/conf.d/
#endregion

EXPOSE 9000 22
CMD sh /tmp/php-starter.sh


