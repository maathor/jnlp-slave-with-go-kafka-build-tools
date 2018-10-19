FROM cloudbees/jnlp-slave-with-java-build-tools

MAINTAINER Maathor <mrichard@slimpay.com>

USER root

ENV GOLANG_VERSION 1.10.3
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz

ENV GOLANG_DOWNLOAD_SHA256 fa1b0e45d3b647c252f51f5e1204aba049cde4af177ef9f2181f43004f901035
RUN wget "$GOLANG_DOWNLOAD_URL" -O golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH $HOME/workspace/gopath
ENV GOROOT /usr/local/go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH
RUN mkdir -p $GOPATH
RUN chmod 777 $GOPATH

RUN apt-get update && apt-get install -y make gcc git rsync pkg-config lxc-dev wget build-essential && \
    apt-get clean && \
    rm -fr /tmp/* /var/tmp/*

WORKDIR /tmp/
RUN git clone https://github.com/edenhill/librdkafka.git
WORKDIR /tmp/librdkafka
RUN git checkout v0.11.5 && git checkout -b v0.11.5
RUN ./configure --disable-lz4 --disable-ssl --disable-sasl && make && make install
RUN cd /tmp && rm -rf librdkafka
WORKDIR /home/jenkins
USER jenkins
