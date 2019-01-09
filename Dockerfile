FROM openjdk:8-jdk

ARG SOURCE_JAR_FILE=build/libs/config-server-*.jar
ENV JAR_FILE=/var/myapp/config-server.jar

COPY ${SOURCE_JAR_FILE} ${JAR_FILE}

ARG user=bootapp
ARG group=bootapp
ARG uid=10002
ARG gid=10002

RUN set -o errexit -o nounset \
	&& echo "Adding user and group" \
	&& groupadd --system --gid ${gid} ${group} \
	&& useradd --system --gid ${gid} --uid ${uid} --shell /bin/bash -m ${user}

RUN chown ${user}:${group} ${JAR_FILE}

RUN chmod 500 ${JAR_FILE}

USER bootapp

EXPOSE 8888

ENTRYPOINT ["java"]
CMD ["-jar", "${JAR_FILE}"]

