# Etapa de build
FROM maven:3.9.9-eclipse-temurin-21-alpine AS build
RUN apk update
RUN adduser -D userapp
USER userapp
WORKDIR /app
COPY --chown=userapp:userapp . .
RUN mvn clean package -DskipTests

# Etapa de runtime
FROM eclipse-temurin:21-alpine
RUN adduser -D userapp
USER userapp
WORKDIR /app
COPY --from=build /app/target/app-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
