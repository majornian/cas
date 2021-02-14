#!/bin/bash

java -jar app/build/libs/app.jar &
pid=$!
sleep 15
rm -Rf tmp &> /dev/null
mkdir tmp
cd tmp
curl http://localhost:8080/starter.tgz -d type=cas-mgmt-overlay | tar -xzvf -
kill -9 $pid

echo "Building CAS Mgmt Overlay"
./gradlew clean build --no-daemon

chmod +x *.sh

echo "Build Container Image w/ Docker"
./docker-build.sh
