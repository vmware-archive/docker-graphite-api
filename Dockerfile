#
#  Copyright 2015 VMware, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
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
