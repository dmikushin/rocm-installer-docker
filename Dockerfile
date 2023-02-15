FROM ubuntu:20.04
MAINTAINER Dmitry Mikushin <dmitry@kernelgen.org>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        lsb-release \
        ca-certificates \
        curl \
        wget \
        gnupg

COPY ./install.sh / 

ENV PATH "${PATH}:/opt/rocm/bin"

