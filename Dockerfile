# Первый этап сборки
FROM ubuntu:latest AS build

# Обновление списка пакетов и установка необходимых инструментов в одном RUN слое
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    wget \
    unzip && \
    wget https://services.gradle.org/distributions/gradle-7.2-bin.zip && \
    unzip gradle-7.2-bin.zip && \
    mv gradle-7.2 /opt/gradle && \
    rm gradle-7.2-bin.zip

# Установка переменной окружения для Gradle
ENV PATH=/opt/gradle/bin:$PATH

# Копирование скрипта gradlew и установка разрешений на выполнение
COPY gradlew .
RUN chmod +x ./gradlew

# Копирование остальных файлов проекта
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
