#FROM ubuntu:latest
#LABEL authors="PM915QF"
#
#ENTRYPOINT ["top", "-b"]

FROM openjdk:17

EXPOSE 8082

LABEL maintainer="docService"

COPY target/doc-service.jar /doc-service.jar

ENTRYPOINT ["java", "-jar", "/doc-service.jar"]


#Terminal run command
#docker build -t docService . //docService -> you can use anything you want insted of "docService"
#docker run -p 8082:8082 -d docservice
#docker rm -f <CONTAINER ID >  //you have to replace with id for remove
