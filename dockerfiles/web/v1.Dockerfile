FROM alpine/git:latest AS git
RUN mkdir -p /git && cd /git && git clone https://github.com/hkhcoder/vprofile-project.git
FROM maven:3.9-eclipse-temurin-17-alpine AS build
COPY --from=git /git/vprofile-project/* /app/
RUN cd /app && mvn install -DskipTests && mkdir -p /app/target/ROOT && cd /app/target/ROOT && jar -xf /app/target/vprofile-v2.war
FROM tomcat:jre17-temurin-noble
COPY --from=build /app/target/ROOT /usr/local/tomcat/webapps/ROOT
EXPOSE 8080
CMD ["catalina.sh", "run"]