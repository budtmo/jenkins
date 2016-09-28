Docker Container as jenkins node
================================
Use docker container as jenkins node.

Requirements
------------
1. Enable Port **1** in option **TCP port for JNLP agents**
2. Dummy node is created in jenkins

Quick Start
-----------
1. Build your custom docker image that will be used as node (example: PythonNode)
	
	```bash
	$docker build -t <image_name> -f <Dockerfile_name> --build-arg JENKINS_URL=<jenkins_url> <path>
	```

	An example:
	
	```bash
	$docker build -t docker_python -f example/PythonNode --build-arg JENKINS_URL=http://127.0.0.1:8080 example
	```

2. Run that docker image
	
	```bash
	$docker run -d --name <container_name> -e NODE=<node_name> -e USER=<jenkins_username> -e PASSWORD=<jenkins_password> <docker_image_name>
	```

	An example:
	
	```bash
	$docker run -d --name python_node -e NODE=python_node -e USER=butomo -e PASSWORD=secr3t docker_python
	```

Build your own custom node! 
