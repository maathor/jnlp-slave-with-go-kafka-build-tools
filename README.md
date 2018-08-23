# Description
Extends cloudbees/jnlp-slave-with-java-build-tools so it can be used as a Jenkins JLNP slave, for use with Jenkins Cloud plugins.

See README for details on available tools.

# How to use this Docker image

This Docker image is intended to be used in conjunction with a Docker container orchestration service such as
- Amazon EC2 Container Service
It can also be used "static" Jenkins slave connected to a Jenkins master declaring a JNLP slave but it would require to manually launch the Docker container.

# Running
To run a Docker container

docker run maathor/jnlp-slave-with-go-kafka-build-tools -url http://jenkins-server:port <secret> <slave name>

optional environment variables:

- JENKINS_URL: url for the Jenkins server, can be used as a replacement to -url option, or to set alternate jenkins URL
- JENKINS_TUNNEL: (HOST:PORT) connect to this slave host and port instead of Jenkins server, assuming this one do route TCP traffic to Jenkins master. Useful when when Jenkins runs behind a load balancer, reverse proxy, etc.

# Docker image details

## Version latest
OS: Ubuntu 16.04

Common tools: openssh-client, unzip, wget, curl, git, jq, rsync

Ant 1.10.4

AWS CLI: aws-cli/1.15.53

Azure CLI: 2.0.41

Bower: 1.8.4

Cloud Foundry CLI (latest) at /usr/local/bin/cf: 6.37.0

Firefox at /usr/bin/firefox: 60.1.0esr

Firefox Geckodriver at /usr/bin/geckodriver: v0.21.0

gcc (latest): 5.4.0

Grunt CLI: 1.2.0

Gulp: 4.0.0

Java: OpenJDK 8 (latest): 1.8.0_162

JMeter (4.0) located in /opt/jmeter/

Kubernetes CLI at /usr/local/bin/kubectl: 1.10.0

Make (latest): 4.1

Maven located in /usr/share/maven/: 3.5.4

MySQL Client: 5.7.22

Node.js at /usr/bin/nodejs: 8.11.3

Npm at /usr/bin/npm: 5.6.0

Open Shift V3 CLI at /usr/local/bin/oc: 3.9.0

Python/2.7.12

Selenium at /opt/selenium/selenium-server-standalone.jar: 3.13.0

XVFB: 2:1.18.4

Jenkins slave.jar (aka remoting.jar) at /usr/share/jenkins/slave.jar: 3.23

librdkafka v0.11.4

go 1.8
