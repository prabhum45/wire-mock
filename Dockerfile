FROM java:openjdk-8-jdk-alpine

RUN ls
ADD mappings /mappings/
ENV WIREMOCK_VERSION 2.18.0
RUN apk add --update --no-cache curl
RUN curl -sSL https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/${WIREMOCK_VERSION}/wiremock-standalone-${WIREMOCK_VERSION}.jar -o /wiremock.jar
CMD ["80"]  # Default port
ENTRYPOINT ["java", "-Xmx4g", "-jar", "/wiremock.jar", "--verbose", "--local-response-templating" , "--port"]
