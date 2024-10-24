FROM ubuntu:20.04

RUN apt-get update && apt-get install -y
RUN apt-get update && apt-get install -y openjdk-21-jdk

RUN java -version

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"
ENV DEVOPS=mkaleda

LABEL description="Description for image in task 3"

COPY target/task3-0.0.1.jar task3.jar

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]