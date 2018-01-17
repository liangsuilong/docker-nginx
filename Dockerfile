FROM ubuntu:16.04

MAINTAINER  Suilong Liang <suilong.liang@worktogether.io>

ENV LC_ALL C.UTF-8

# Manually Add Nginx Stable PPA https://launchpad.net/~nginx/+archive/ubuntu/stable
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 8B3981E7A6852F782CC4951600A6F0A3C300EE8C && \
    echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu xenial main" >> /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get -y install nginx-full && \
    rm -f /etc/nginx/sites-enabled/default && \
    apt-get clean 

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
VOLUME /etc/nginx/sites-enabled/
EXPOSE 80 443
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["start"]
