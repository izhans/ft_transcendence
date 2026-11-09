# Development Dockerfile 1.0 (in /backend alongside the rest of the service)

FROM eclipse-temurin:25-jdk
WORKDIR /app
COPY . /app/
RUN apt update -y && apt install -y maven curl && mvn package
CMD ["java", "-jar", "target/backend-0.0.1-SNAPSHOT.jar"]
