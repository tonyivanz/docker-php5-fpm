# Pull from the ubuntu:14.04 image
FROM ubuntu:14.04
LABEL maintainer="Tony Ivanz <tony@ivanz.ru>"

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# install typical php packages and then additional packages
RUN apt-get update && apt-get -y upgrade && && apt-get -y dist-upgrade && \
  apt-get install -y php5-curl php5-fpm php5-mcrypt php5-mysql wget whois curl mcrypt net-tools
 
# Configure PHP settings
RUN sed -i -e 's/expose_php = On/expose_php = Off/g' /etc/php5/fpm/php.ini
RUN sed -i -e 's/;default_charset = "iso-8859-1"/default_charset = "UTF-8"/g' /etc/php5/fpm/php.ini
RUN sed -i -e 's/;daemonize\s*=\s*yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf
RUN sed -i -e 's/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g' /etc/php5/fpm/pool.d/www.conf
RUN sed -i -e 's/pm.max_requests = 500/pm.max_requests = 200/g' /etc/php5/fpm/pool.d/www.conf
RUN sed -i -e 's/listen = \/var\/run\/php5-fpm.sock/listen = 9000/g' /etc/php5/fpm/pool.d/www.conf

RUN mkdir -p /var/www

EXPOSE 9000
VOLUME /var/www
ENTRYPOINT ["/usr/sbin/php-fpm5.6"]