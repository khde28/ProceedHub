# Stage 1: Construcción de la aplicación
FROM gradle:8.7-jdk21 AS builder
WORKDIR /app
COPY build.gradle settings.gradle /app/
COPY src /app/src
# Compila la aplicación ignorando los tests para ser más rápido
RUN gradle build -x test --no-daemon

# Stage 2: Ejecución de la aplicación
FROM eclipse-temurin:21-jre-alpine
LABEL authors="natzgun"
WORKDIR /app
COPY --from=builder /app/build/libs/ProceedHub-0.0.1-SNAPSHOT.jar /app/ProceedHub-0.0.1-SNAPSHOT.jar

EXPOSE 8086

CMD ["java", "-jar", "ProceedHub-0.0.1-SNAPSHOT.jar"]