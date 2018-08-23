FROM cloudbees/jnlp-slave-with-java-build-tools

MAINTAINER Maathor <mrichard@slimpay.com>

USER root

ENV GOLANG_VERSION 1.8
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz

ENV GOLANG_DOWNLOAD_SHA256 53ab94104ee3923e228a2cb2116e5e462ad3ebaeea06ff04463479d7f12d27ca
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

RUN apt-get update && apt-get install -y confluent-platform-oss-2.11 librdkafka-dev && \
	rm -fr /var/lib/apt/lists/*

WORKDIR /home/jenkins
USER jenkins
