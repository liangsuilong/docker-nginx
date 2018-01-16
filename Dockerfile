FROM ubuntu:16.04

MAINTAINER  Suilong Liang <suilong.liang@worktogether.io>

ENV LC_ALL C.UTF-8

#RUN sed 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' -i /etc/apt/sources.list && \
#    sed 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' -i /etc/apt/sources.list && \
Run apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:nginx/stable && \
    # sed 's/ppa.launchpad.net/launchpad.proxy.ustclug.org/g' -i `grep ppa.launchpad.net -rl /etc/apt/sources.list.d/` && \
    apt-get -y update && \
    apt-get -y install nginx-full && \
    apt-get clean 

# Add php-fpm as backend
ARG PHP_UPSTREAM_CONTAINER=php
ARG PHP_UPSTREAM_PORT=9000
RUN echo "upstream php { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/sites-enabled/php-upstream.conf

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
VOLUME /etc/nginx/sites-enabled/
EXPOSE 80 443
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["start"]
