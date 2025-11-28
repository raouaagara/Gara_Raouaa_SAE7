# Etape 1 : Build du projet Spring Boot
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etape 2 : Image finale plus légère
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Port exposé
EXPOSE 8089

# Commande pour démarrer l'application
ENTRYPOINT ["java","-jar","app.jar"]
