# Usar una imagen base de Maven para construir el proyecto
FROM maven:3.8.1-openjdk-11 AS build

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos de configuración de Maven
COPY pom.xml .

# Descargar las dependencias de Maven
RUN mvn dependency:go-offline -B

# Copiar el resto del código fuente
COPY src ./src

# Construir el proyecto usando Maven
RUN mvn package -DskipTests

# Usar una imagen base de OpenJDK para ejecutar el proyecto
FROM openjdk:11-jre-slim

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo JAR del contenedor de compilación
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Exponer el puerto en el que la aplicación escuchará
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
