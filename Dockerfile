# Use the official Maven image to create a build artifact
FROM maven:3.8.3-openjdk-17 as builder
WORKDIR /app
COPY . .
RUN mvn clean package

# Use the official OpenJDK image for the final stage
FROM openjdk:17
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

COPY src/main/resources/application.properties /app/application.properties

EXPOSE 5719
ENTRYPOINT ["java", "-jar", "app.jar"]
