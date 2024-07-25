#!/bin/bash

# Устанавливаем Gradle
GRADLE_VERSION=8.7
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip gradle-${GRADLE_VERSION}-bin.zip
export PATH=$PATH:`pwd`/gradle-${GRADLE_VERSION}/bin

# Собираем проект
gradle build

# Запускаем проект
gradle run
