# rpi-python-networkx

Raspberry Pi compatible Docker base image with Python 3.5 and networkx preinstalled.

* [Docker hub repository](https://hub.docker.com/r/hbaltz/rpi-python-networkx/)


## Description

Raspbian + python 3.5 + networkx with some modifications :

* WORKDIR set to /data/

## Usage

### Run the image

* Pull the image `docker pull hbaltz/rpi-python-networkx`
* Run a python command `docker run hbaltz/rpi-python-networkx python <a-python-command>`

### Compile the image yourself

* Clone the git repository [https://github.com/hbaltz/docker_image_rpi-python-networkx.git]( https://github.com/hbaltz/docker_image_rpi-python-networkx.git)
* In the repository, launch the compilation : `docker build -t <the-tag-you-want> ./`

## Example

* To see the version of python install launch : `docker run hbaltz/rpi-python-networkx python --version`

## Summary

A docker image with python 3.5.2 and networkx installed

