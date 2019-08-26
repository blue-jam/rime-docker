FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq -y update && apt-get -qq -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get -qq -y update && apt-get -qq -y install \
      build-essential \
      curl \
      g++-9 \
      libbz2-dev \
      libdb-dev git \
      libreadline-dev \
      libffi-dev \
      libgdbm-dev \
      liblzma-dev \
      libncursesw5-dev \
      libsqlite3-dev \
      libssl-dev \
      python \
      python-pip \
      tk-dev \
      unzip \
      uuid-dev \
      zip \
      zlib1g-dev

# Install Python3
RUN /bin/bash -c '\
  curl -o python.tar.gz \
    -L https://github.com/python/cpython/archive/v3.7.4.tar.gz; \
  tar -xf python.tar.gz; \
  cd cpython-3.7.4; \
  ./configure --quiet --enable-shared; \
  make --quiet; \
  make install --quiet; \
  sh -c "echo '/usr/local/lib' > /etc/ld.so.conf.d/custom_python3.conf"; \
  ldconfig; \
  rm -R /python.tar.gz /cpython-3.7.4'
RUN pip install six

RUN pip3 install git+https://github.com/icpc-jag/rime

RUN curl -s "https://get.sdkman.io" | bash
RUN /bin/bash -c -l '\
  source $HOME/.sdkman/bin/sdkman-init.sh; \
  sdk install java; \
  sdk install kotlin; \
  ln -s $(which javac) /bin/javac; \
  ln -s $(which java) /bin/java; \
  ln -s $(which kotlin) /bin/kotlin; \
  ln -s $(which kotlinc) /bin/kotlinc'

RUN ln -s -f /usr/bin/g++-9 /usr/bin/g++
