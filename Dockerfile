# -----------------------
# Étape 1 : Build Maven
# -----------------------
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copier seulement les fichiers nécessaires pour Maven (optimisation du cache)
COPY pom.xml .
COPY src ./src

# Build le projet et créer le jar (sans tests)
RUN mvn clean package -DskipTests

# -----------------------
# Étape 2 : Image finale légère
# -----------------------
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copier le jar buildé depuis l'étape précédente
COPY --from=build /app/target/student-management-0.0.1-SNAPSHOT.jar ./app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

