FROM ubuntu:16.04

RUN apt-get update \
  && apt-get install -y \
  g++ make less curl unzip \
  automake autoconf libtool cpputest \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /work

RUN mkdir /tools \
  && cd /tools/ \
  && curl -LOk https://github.com/cpputest/cpputest/archive/v3.6.zip \
  && unzip v3.6.zip \
  && rm v3.6.zip \
  && cd cpputest-3.6/ \
  && ./configure \
  && make check \
  && make tdd

RUN echo "export CPPUTEST_HOME=/tools/cpputest-3.6" >> ~/.bashrc
WORKDIR /work
