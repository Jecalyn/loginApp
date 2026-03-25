FROM tomcat:11.0.13-jdk21-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR into webapps
COPY loginapp.war /usr/local/tomcat/webapps/loginApp.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
