# build
from maven:3.8-jdk-11 as build
workdir /usr/app
copy pom.xml pom.xml
copy src src
run mvn package

# run
from openjdk:11
copy --from=build /usr/app/target/*.jar app.jar
expose 8080
cmd ["java", "-jar", "app.jar"]
