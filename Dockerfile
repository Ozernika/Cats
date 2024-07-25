# Первый этап сборки
FROM ubuntu:latest AS build

# Обновление списка пакетов и установка необходимых инструментов
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Установка Gradle (если его нет в проекте)
RUN wget https://services.gradle.org/distributions/gradle-7.2-bin.zip \
    && unzip gradle-7.2-bin.zip \
    && mv gradle-7.2 /opt/gradle \
    && rm gradle-7.2-bin.zip

# Установка переменной окружения для Gradle
ENV PATH=/opt/gradle/bin:$PATH

# Копирование файлов проекта в контейнер
COPY gradlew /build/
COPY gradle /build/gradle
COPY src /build/src
COPY build.gradle /build/

# Установка разрешений на выполнение для gradlew
RUN chmod +x /build/gradlew

# Сборка JAR файла с использованием Gradle
WORKDIR /build
RUN ./gradlew bootJar --no-daemon --parallel

# Второй этап, более легкий образ для запуска
FROM openjdk:17-jdk-slim

# Открытие порта 8080
EXPOSE 8080

# Копирование JAR файла из первого этапа
COPY --from=build /build/libs/Test-0.0.1-SNAPSHOT.jar app.jar

# Определение команды для запуска приложения
ENTRYPOINT ["java", "-jar", "app.jar"]
