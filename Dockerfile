# Pull base image
FROM resin/raspberrypi3-buildpack-deps:jessie

MAINTAINER Hugo Baltz <hugobaltz@gmail.com>

# Proxy settings
ENV http_proxy http://10.0.4.2:3128
ENV https_proxy https://10.0.4.2:3128

# remove several traces of debian python
RUN apt-get purge -y python.*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# install python and networkx dependencies 
RUN apt-get update && apt-get install -y --no-install-recommends \
		libc6-dev \
		libncurses5-dev libncursesw5-dev libreadline6-dev \
		libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev \
		libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev \
		libgeos-dev\
		build-essential \
		wget \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get -y autoremove

# Install python3
RUN cd $HOME &&  wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz && \
	tar -zxvf Python-3.5.2.tgz && cd Python-3.5.2 && \
	./configure && make -j4  && make install && \
	cd .. && rm -fr ./Python-3.5.2*

# upgrade:
RUN pip3 install -U pip && \
	pip3 install -U setuptools

# Install networkx
RUN python3.5 -m pip install networkx && \
	python3.5 -m pip install shapely

# make some useful symlinks that are expected to exist
RUN cd /usr/local/bin \
	&& ln -sf pip3 pip \
	&& ln -sf easy_install-3.5 easy_install \
	&& ln -sf idle3 idle \
	&& ln -sf pydoc3 pydoc \
	&& ln -sf python3 python \
	&& ln -sf python-config3 python-config

# Define working directory
WORKDIR /data

# Define default command
CMD ["bash"]

ENV PYTHONPATH /usr/lib/python3/dist-packages

