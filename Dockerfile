FROM stackbrew/ubuntu:14.04

MAINTAINER  Anne Ebie <aebie@vmware.com>

VOLUME /srv/graphite

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get install -y build-essential
RUN apt-get install -y python-dev
RUN apt-get install -y libffi-dev
RUN apt-get install -y libcairo2-dev
RUN apt-get install -y python-pip
RUN apt-get install -y graphite-carbon
RUN pip install gunicorn graphite-api[sentry,cyanite]

ENV GRAPHITE_UI_PORT 8000
ENV GRAPHITE_LISTEN_PORT 2003
EXPOSE ${GRAPHITE_UI_PORT}
EXPOSE ${GRAPHITE_LISTEN_PORT}

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh
