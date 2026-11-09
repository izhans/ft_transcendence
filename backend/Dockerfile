#Dockerfile de desarrollo 1.0 (en /backend junto con el resto del servicio)

FROM eclipse-temurin:25-jdk
WORKDIR /app
COPY . /app/
RUN apt update -y && apt install -y maven && mvn package
CMD ["java", "-jar", "target/backend-0.0.1-SNAPSHOT.jar"]