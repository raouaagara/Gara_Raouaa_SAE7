# -----------------------------
# Étape 1 : Build Maven
# -----------------------------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier seulement les fichiers nécessaires pour optimiser le cache
COPY pom.xml .
COPY src ./src

# Compiler et packager l'application
RUN mvn clean package -DskipTests

# -----------------------------
# Étape 2 : Image finale légère
# -----------------------------
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copier le jar depuis l'étape de build
COPY --from=build /app/target/student-management-0.0.1-SNAPSHOT.jar app.jar

# Définir le point d'entrée
ENTRYPOINT ["java", "-jar", "app.jar"]
