Docker Jenkins
==============
This project shows how to run Jenkins master and slave(s) in Docker solution.

Requirements
------------
1. Docker

Start Jenkins Master
--------------------
1. Run Jenkins machine through docker-compose
	
	```bash
	$docker-compose up
	```

2. Access <docker-host-ip>:8080 from your web browser.

**If you run this docker-jenkins for the first time, please do this step to be able to create first admin account:**

Read and copy the initial admin password from the logs and paste it in the Getting started page

Connect Jenkins Node
--------------------

You are able to have a Jenkins slave(s) / node(s) on demand.

1. Enable Docker Engine API on the machine which has Docker installed. 

2. Install [Docker plugin](http://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin) in Jenkins (under Manage Jenkins -> Manage Plugins)

3. Configure the connection between slave and Docker (under Manage Jenkins -> Configure System -> Cloud). Sample config:

	```bash
	Name: slave1
	Docker Host URI: tcp://xxx.xxx.xxx.xxx:xxx
	Enabled: true
	```

4. Configure Docker agent template in the same page. Sample config:
	
	```bash
	Label: java
	Enabled: true
	Name: docker-openjdk
	DockerImage: openjdk
	Connect method: Attach Docker container
	Pull strategy: Pull all images every time
	```

5. Based on above configuration, you can create a job with option "Restrict where this project can be run: java"


Additional information
----------------------

1. [List of Docker images](node) that can be used as Jenkins slave / node

2. [Sample of using in Jenkins pipeline](pipeline)
