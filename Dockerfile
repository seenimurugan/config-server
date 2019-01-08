FROM openjdk:8-jdk

COPY build/libs/config-server-*.jar /var/myapp/config-server.jar

ARG user=bootapp
ARG group=bootapp
ARG uid=10002
ARG gid=10002

#RUN apt-get update && \
#      apt-get -y install sudo

RUN set -o errexit -o nounset \
	&& echo "Adding user and group" \
	&& groupadd --system --gid ${gid} ${group} \
	&& useradd --system --gid ${gid} --uid ${uid} --shell /bin/bash -m ${user}

RUN chown ${user}:${group} /var/myapp/config-server.jar

#RUN chattr +i /var/myapp/config-server.jar

RUN chmod 500 /var/myapp/config-server.jar

RUN ln -s /var/myapp/config-server.jar /etc/init.d/config-server

USER bootapp

EXPOSE 8888

ENTRYPOINT ["service", "config-server", "start"]

