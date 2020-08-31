FROM nginx:latest

ADD nginx.conf /etc/nginx/
ADD conf.d/ /etc/nginx/conf.d/
ADD sites/default.conf /etc/nginx/sites-available/

CMD ["nginx"]

EXPOSE 80 443