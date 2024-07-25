

# Второй этап, более легкий образ для запуска
FROM openjdk:17-jdk-slim

# Открытие порта 8080
EXPOSE 8080

# Копирование JAR файла из первого этапа
COPY --from=build /build/libs/Test-0.0.1-SNAPSHOT.jar app.jar

# Определение команды для запуска приложения
ENTRYPOINT ["java", "-jar", "app.jar"]
