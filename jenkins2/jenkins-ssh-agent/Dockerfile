FROM ubuntu:16.04
MAINTAINER Kishore Bhatia <bhatia dot kishore at gmail dot com>

# Make sure the package repository is up to date.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git
# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN apt-get install -y openjdk-7-jdk

#add Docker
USER root
RUN curl -L -o /tmp/docker-latest.tgz https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
  && tar xzf /tmp/docker-latest.tgz -C /tmp/ \
  && mv /tmp/docker/* /usr/bin/ \
  && chmod a+x /usr/bin/docker* \
  && rm -rf /tmp/docker* \
  && delgroup staff \
  && groupadd -g 50 docker \
  && groupadd staff \
  && adduser jenkins docker \
  && adduser root docker
  
# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# RUN mkdir /home/jenkins/.m2
# ADD settings.xml /home/jenkins/.m2/
# RUN chown -R jenkins:jenkins /home/jenkins/.m2/ 
# RUN apt-get install -y maven

RUN mkdir -p /tmp/scripts/
ADD ./bootstrap.sh /tmp/scripts/bootstrap.sh
RUN ./bootstrap.sh

# Standard SSH port
EXPOSE 22
