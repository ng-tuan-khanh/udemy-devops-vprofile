FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
RUN git clone https://github.com/hkhcoder/vprofile-project.git
WORKDIR /app/vprofile-project
RUN mvn install -DskipTests && mkdir -p ROOT && cd ROOT && jar -xf /app/vprofile-project/target/vprofile-v2.war
FROM tomcat:jre17-temurin-noble
COPY --from=build /app/vprofile-project/ROOT /usr/local/tomcat/webapps/ROOT
EXPOSE 8080
CMD ["catalina.sh", "run"]