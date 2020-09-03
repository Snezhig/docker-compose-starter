FROM nginx:latest

ADD nginx.conf /etc/nginx/
ADD conf.d/ /etc/nginx/conf.d/
ADD sites/default.conf /etc/nginx/sites-available/

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80 443