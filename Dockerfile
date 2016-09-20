FROM butomo1989/ubuntu1604

# Install jenkins LTS Release version
RUN wget http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/2.7.4/jenkins-war-2.7.4.war

# Expose port to access ui
EXPOSE 8080

# Export port for nodes
EXPOSE 1

# Run jenkins
CMD java -jar jenkins-war-2.7.4.war
