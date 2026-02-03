# Etapa 1: Construcción con Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Despliegue en Tomcat
FROM tomcat:10.1-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/PAGINA_WE-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Railway usa la variable PORT, configuramos Tomcat para usarla
ENV CATALINA_OPTS="-Dport.http=$PORT"
EXPOSE 8080

# Script para usar el puerto de Railway si existe
CMD ["sh", "-c", "catalina.sh run"]
