FROM openjdk:8

RUN git clone https://github.com/docker-hy/spring-example-project.git /app

WORKDIR /app

RUN /app/mvnw package

ENTRYPOINT ["java", "-jar", "/app/target/docker-example-1.1.3.jar"]
