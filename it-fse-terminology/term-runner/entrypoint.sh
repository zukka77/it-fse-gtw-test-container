#!/bin/bash

if [ -z $BRANCH -o -z $URL -o -z $PORT ]; then
    echo "please specify enviroments for repo URL, repo BRANCH, service PORT"
    exit
fi

mkdir -p /app
cd /app


if [ ! -d /app/.git ];then #clone only the first time
    git clone --depth=1 --branch $BRANCH $URL . ||  { echo "fatal: failed to clone branch '$BRANCH' at url '$URL'" && exit 1; }
    git config pull.ff only
fi
git pull ||  { echo "fatal: failed to pull branch '$BRANCH' at url '$URL'" && exit 1; }

echo "running: mvn spring-boot:run -Dspring-boot.run.profiles=docker -Dspring-boot.run.arguments=\"--management.server.port=$PORT --server.port=$PORT\""
#Put configuration in to place
cp ../application-docker.properties .
#Inject Postgres jdbc dependency in pom2.xml
sed 's/<dependencies>/<dependencies>\n<!--postgres-->\n<dependency>\n<groupId>org.postgresql<\/groupId>\n<artifactId>postgresql<\/artifactId>\n<version>42.6.0<\/version>\n<\/dependency>\n<!--postgres-->/g' pom.xml > pom2.xml
#We use pom2.xml with injected dependency
exec mvn -f pom2.xml spring-boot:run -Dspring-boot.run.profiles=docker -Dspring-boot.run.arguments="--management.server.port=$PORT --server.port=$PORT"