FROM openjdk:17-jdk-alpine
EXPOSE 8081
COPY target/web-0.0.1-SNAPSHOT.jar web-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/web-0.0.1-SNAPSHOT.jar"]