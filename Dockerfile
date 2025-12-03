FROM  maven:3.9.6-eclipse-temurin-8 AS build
WORKDIR /app
COPY pom.xml  /app/pom.xml
RUN mvn dependency:go-offline 
COPY src  /app/src
RUN  mvn clean package -DskipTests


FROM eclipse-temurin:8-jre
WORKDIR /app
COPY --from=build /app/target/*.jar  app.jar
EXPOSE 8000
ENTRYPOINT [ "java", "-jar", "app.jar" ]
