# Build with Maven & Deploy to Tomcat

# stage 1
FROM maven As Build
WORKDIR /app
COPY ./app
RUN mvn clean package

stage 2
FROM Tomcat
COPY --from=build /app/target/*war webapps
