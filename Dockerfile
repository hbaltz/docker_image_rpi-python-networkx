# Pull base image
FROM jsurf/rpi-raspbian:latest

MAINTAINER Hugo Baltz <hugobaltz@gmail.com>

# Proxy settings
ENV http_proxy http://10.0.4.2:3128
ENV https_proxy https://10.0.4.2:3128

# Install necessary packages
RUN apt-get update && apt-get install -y build-essential libc6-dev \
	libncurses5-dev libncursesw5-dev libreadline6-dev \
	libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev \
	libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev wget libgeos-dev\
	--no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

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

# Define working directory
WORKDIR /data

# Define default command
CMD ["bash"]
