ARG version
FROM mariadb:${version}

MAINTAINER snezhig

COPY conf.d/ /etc/mysql/conf.d/

CMD ["mysqld", "--innodb-use-native-aio=0", "--ignore-db-dir=losf+found", "--innodb-flush-method=O_DIRECT"]

EXPOSE 3306