FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get -y install g++-9 build-essential libbz2-dev libdb-dev git \
      libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev \
      libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev curl zip unzip \
      python python-pip

# Install Python3
RUN /bin/bash -c '\
  curl -o python.tar.gz \
    -L https://github.com/python/cpython/archive/v3.7.4.tar.gz; \
  tar -xvf python.tar.gz; \
  cd cpython-3.7.4; \
  ./configure --enable-shared; \
  make; \
  make install; \
  sh -c "echo '/usr/local/lib' > /etc/ld.so.conf.d/custom_python3.conf"; \
  ldconfig; \
  rm -R /python.tar.gz /cpython-3.7.4'
RUN pip install six

RUN pip3 install git+https://github.com/icpc-jag/rime

RUN curl -s "https://get.sdkman.io" | bash
RUN /bin/bash -c -l '\
  source $HOME/.sdkman/bin/sdkman-init.sh; \
  sdk install java; \
  sdk install kotlin'

RUN ln -s -f /usr/bin/g++-9 /usr/bin/g++