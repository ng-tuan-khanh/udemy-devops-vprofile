FROM maven:3.9-eclipse-temurin-17-alpine AS build
WORKDIR /app
ADD https://github.com/hkhcoder/vprofile-project.git .
RUN mvn install -DskipTests && mkdir -p ROOT && cd ROOT && jar -xf /app/target/vprofile-v2.war
FROM tomcat:jre17-temurin-noble
COPY --from=build /app/ROOT /usr/local/tomcat/webapps/ROOT
EXPOSE 8080
CMD ["catalina.sh", "run"]