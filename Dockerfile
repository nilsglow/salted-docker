FROM debian:jessie
MAINTAINER Nils Kalchhauser <nils@studio19.at>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install apt-transport-https wget
RUN wget -O - https://repo.saltstack.com/apt/debian/8/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
RUN echo "deb https://repo.saltstack.com/apt/debian/8/amd64/latest jessie main" >/etc/apt/sources.list.d/saltstack.list
RUN apt-get update
RUN apt-get -y install salt-minion

# SaltStack fail hard if any state fails
ADD minion /etc/salt/minion

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /srv/salt
