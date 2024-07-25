# Первый этап сборки
FROM ubuntu:latest AS build

# Обновление списка пакетов
RUN apt-get update

# Установка OpenJDK 17
RUN apt-get install openjdk-17-jdk -y

# Копирование всех файлов проекта в контейнер
COPY . .

# Сборка JAR файла с использованием Gradle
RUN ./gradlew bootJar --no-daemon

# Второй этап, более легкий образ для запуска
FROM openjdk:17-jdk-slim

# Открытие порта 8080
EXPOSE 8080

# Копирование JAR файла из первого этапа
COPY --from=build /build/libs/Test-0.0.1-SNAPSHOT.jar app.jar

# Определение команды для запуска приложения
ENTRYPOINT ["java", "-jar", "app.jar"]
