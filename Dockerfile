FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /build

COPY pom.xml .
RUN mvn -B dependency:go-offline -DskipTests || true

COPY src ./src
RUN mvn -B -DskipTests package \
    && mkdir -p /out \
    && cp target/x-directory-size-inventory.jar /out/x-directory-size-inventory.jar

# Image holds the built JAR at /out/x-directory-size-inventory.jar for docker-build.sh to copy out.
