# Первый этап сборки зависимостей
FROM openjdk:17-jdk-slim AS dependencies

WORKDIR /app
COPY build.gradle settings.gradle ./
RUN ./gradlew dependencies

# Второй этап сборки
FROM openjdk:17-jdk-slim AS build

WORKDIR /app
COPY --from=dependencies /app/build.gradle /app/
COPY src /app/src
COPY build.gradle settings.gradle ./
RUN ./gradlew bootJar --no-daemon

# Финальный этап
FROM openjdk:17-jdk-slim

EXPOSE 8080
COPY --from=build /app/build/libs/Test-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
