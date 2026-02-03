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

# Copiar script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

# Usar script personalizado que configura el puerto
CMD ["/start.sh"]

