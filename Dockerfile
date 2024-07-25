# Первый этап сборки
FROM ubuntu:latest AS build

# Обновление списка пакетов и установка необходимых инструментов
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    wget \
    unzip

# Установка Gradle (если его нет в проекте)
RUN wget https://services.gradle.org/distributions/gradle-7.2-bin.zip \
    && unzip gradle-7.2-bin.zip \
    && mv gradle-7.2 /opt/gradle

# Установка переменной окружения для Gradle
ENV PATH=/opt/gradle/bin:$PATH

# Копирование всех файлов проекта в контейнер
COPY . .

# Установка разрешений на выполнение для gradlew
RUN chmod +x ./gradlew

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
