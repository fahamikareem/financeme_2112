FROM ubuntu AS PRIMARY
MAINTAINER FAHAMI
WORKDIR /app
RUN apt update && apt install -y git && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/fahamikareem/FinanceMe_2112.git .

# Step 2: Maven stage for building the project
FROM maven:3.8.3-jdk-11-slim AS MAVEN
WORKDIR /app
COPY --from=PRIMARY /app /app
RUN mvn compile && mvn test && mvn package

# Step 3: JDK stage for running the JAR file
FROM openjdk:17-alpine AS JDK
WORKDIR /app
COPY --from=MAVEN /app/target/banking-0.0.1-SNAPSHOT.jar /app/finme.jar

# Step 4: Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/finme.jar"]
EXPOSE 8081
