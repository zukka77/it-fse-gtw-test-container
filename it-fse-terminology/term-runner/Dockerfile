FROM docker.io/maven:3-openjdk-17
COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh
WORKDIR /app
#Can't put it in /app or clone would fail
COPY application-docker.properties /
ENTRYPOINT [ "/entrypoint.sh" ]