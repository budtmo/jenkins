FROM ubuntu:16.04

# Update system
RUN apt-get update && apt-get upgrade -y

# Install open jdk
RUN apt-get install -y openjdk-8-jdk

# Install wget
RUN apt-get install wget

# Install jenkins LTS Release version
RUN wget http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/2.7.4/jenkins-war-2.7.4.war

# Expose port 8080
EXPOSE 8080

# Run jenkins
CMD java -jar jenkins-war-2.7.4.war
