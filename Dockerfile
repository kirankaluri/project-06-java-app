FROM eclipse-temurin:21-jre

LABEL maintainer="Kiran Kumar"
LABEL project="Project06"

WORKDIR /app

COPY target/project06-java-app-1.0.0.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
