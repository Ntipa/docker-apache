FROM debian:stable
MAINTAINER Daniele Giglio <giglio.d@gmail.com>

RUN apt-get update && apt-get -y install apache2
RUN apt-get install -y git
RUN cd /var/www/ && git clone https://github.com/Ntipa/jssip-demos.git
RUN cd /var/www/ && /bin/ln -sf jssip-demos/tryit/index.html index.html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN /bin/ln -sf ../sites-available/default-ssl /etc/apache2/sites-enabled/001-default-ssl
RUN /bin/ln -sf ../mods-available/ssl.conf /etc/apache2/mods-enabled/
RUN /bin/ln -sf ../mods-available/ssl.load /etc/apache2/mods-enabled/

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

