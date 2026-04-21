FROM tomcat

RUN apt update

WORKDIR /usr/local/tomcat/webapps
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war
COPY . .


ENTRYPOINT ["catalina.sh", "run"]

EXPOSE 8080
