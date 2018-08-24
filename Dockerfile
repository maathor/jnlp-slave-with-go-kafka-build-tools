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

RUN apt-get update && apt-get install -y make gcc git rsync pkg-config lxc-dev wget && \
    apt-get clean && \
    rm -fr /tmp/* /var/tmp/*

RUN wget -qO - https://packages.confluent.io/deb/5.0/archive.key | apt-key add -

RUN add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/5.0 stable main"

RUN apt-get update && apt-get install -y librdkafka-dev && \
	rm -fr /var/lib/apt/lists/*

WORKDIR /home/jenkins
USER jenkins
