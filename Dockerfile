# vim:set ft=dockerfile:

FROM debian:stable-slim

RUN set -eux; apt-get update; apt-get install -y --no-install-recommends openjdk-11-jre unzip

RUN useradd -ms /bin/bash jettyuser

USER jettyuser
WORKDIR /home/jettyuser

COPY build_components/jetty-home-11.0.7.zip ./
RUN unzip jetty-home-11.0.7.zip

RUN mkdir -p jetty-home/resources
RUN mkdir -p jetty-home/lib/logging
RUN mkdir jetty-home/start.d
RUN mkdir jetty-home/logs
RUN mkdir jetty-home-11.0.7/webapps/
RUN mkdir jetty-home-11.0.7/static_content/

COPY build_components/jetty-logging.properties build_components/log4j2.xml jetty-home/resources/
COPY build_components/log*.jar jetty-home/lib/logging/
COPY build_components/start.d/* jetty-home/start.d/

COPY build_components/expose_static_content.xml jetty-home-11.0.7/webapps/
COPY build_components/static_content/ jetty-home-11.0.7/static_content/
COPY build_components/expose_static_content.xml jetty-home/webapps/
COPY build_components/static_content/ jetty-home/static_content/

EXPOSE 8080
WORKDIR /home/jettyuser/jetty-home
ENV JETTY_HOME="/home/jettyuser/jetty-home-11.0.7"
ENTRYPOINT java -jar $JETTY_HOME/start.jar -Dcom.sun.jndi.ldap.object.trustURLCodebase=true
