# Étape 1 : builder le JAR localement
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
COPY student-management/ .
RUN mvn clean package -DskipTests

# Étape 2 : créer l’image finale légère
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/student-management-0.0.1-SNAPSHOT.jar ./app.jar
ENTRYPOINT ["java","-jar","app.jar"]
