FROM openjdk:24-jdk-slim

ENV DEVOPS=mkaleda

COPY target/task3-0.0.1.jar task3.jar

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]