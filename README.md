Docker Jenkins
==============
This project is about to run jenkins inside docker container in few simplest steps.

Requirements
------------
Docker is installed in host system.

Quick Start
-----------
1. Pull the newest docker-jenkins image
	
	```bash
	$docker pull butomo1989/jenkins
	```

2. Create a folder in current directory (example name: jenkins-workspace)
	
	```bash
	$mkdir jenkins-workspace
	```

3. Run the image and link jenkins-workspace directory with .jenkins directory that is located inside docker container

	```bash
	$docker run -d -p 8080:8080 --name jenkinscontainer -v $PWD/jenkins-workspace:/root/.jenkins butomo1989/jenkins
	```

4. Access <docker-ip-address>:8080 from your web browser.

	4.1. For linux user, you just need to access [localhost:8080] because your host ip-address is the same with docker ip-address

	4.2. For docker-machine user, to find ip address of your docker machine you can use the command:

	```bash
	$docker-machine ip <name_of_activated_docker_machine>
	```

	4.3. For boot2docker user, to find ip address you can use the command:

	```bash
	$boot2docker ip
	```

If you run this docker-jenkins for the first time, please do this step to be able to create first admin account:

5. Read and copy the initial admin password from jenkins-workspace/secrets/initialAdminPassword and paste it in the Getting started page

	```bash
	$cat jenkins-workspace/secrets/initialAdminPassword
	```

	![][InitialAdminPassword]

[InitialAdminPassword]: <img/InitialAdminPassword.png> "Paste the password here"
[localhost:8080]: <http:localhost:8080>
