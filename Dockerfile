FROM openjdk:8-jre-alpine

ARG SOURCE_JAR_FILE=build/libs/config-server*.jar
ENV JAR_FILE=/var/myapp/config-server.jar

COPY ${SOURCE_JAR_FILE} ${JAR_FILE}

ARG user=bootapp
ARG group=${user}
ARG uid=10002
ARG gid=${uid}

#-S = system user -D= user with no password
RUN set -o errexit -o nounset \
	&& echo "Adding user and group" \
	&& addgroup -S -g ${gid} ${group} \
	&& adduser -DS -u ${uid} -G ${group} ${user}

RUN chown ${user}:${group} ${JAR_FILE}

RUN chmod 500 ${JAR_FILE}

USER ${user}

EXPOSE 8080

ENTRYPOINT java -jar $JAR_FILE