# Étape de build
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY student-management/pom.xml .
COPY student-management/src ./src
RUN mvn clean package -DskipTests

# Étape runtime
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8089
ENTRYPOINT ["java","-jar","app.jar"]
