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

2. Open ***http://docker-host-ip-address:8080*** from web browser.

**If you run this docker-jenkins for the first time, please do this step to be able to create first admin account:**

Read and copy the initial admin password from the logs and paste it in the Getting started page

Jenkins node by demand with docker
----------------------------------

You are able to have a Jenkins slave(s) / node(s) on demand through docker.

1. Enable Docker Engine API on the machine which has Docker installed. Example steps on Ubuntu 16.04:

	```bash
	sudo nano /lib/systemd/system/docker.service
	Replace with -> ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:4243
	sudo systemctl daemon-reload
	sudo systemctl restart docker
	curl http://localhost:4243/version
	```

2. Install [Docker plugin](http://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin) in Jenkins (under Manage Jenkins -> Manage Plugins)

3. Configure the connection between jenkins master and Docker machine (under Manage Jenkins -> Configure System -> Cloud). Sample configuration:

	```bash
	Name: cloud1
	Docker Host URI: tcp://xxx.xxx.xxx.xxx:xxx
	Enabled: true
	```

4. Configure Docker agent template in the same page. Sample configuration:
	
	```bash
	Label: java
	Enabled: true
	Name: docker-openjdk
	DockerImage: openjdk
	Connect method: Attach Docker container
	Pull strategy: Pull all images every time
	```

5. Based on above configuration, you can create a job with option "Restrict where this project can be run: java"

Jenkins node by demand with kubernetes
--------------------------------------

You are able to have a Jenkins slave(s) / node(s) on demand through kubernetes but you need to have kubernetes cluster ready before.

1. You need to create jenkins namespace and needed components like ServiceAccount and RoleBinding (run the following command on k8s master node), you need to run [jenkins-cluster.yml](jenkins-cluster.yml)
	
	```
	kubectl apply -f my-jenkins.yml
	```


2. Copy token of created service account:
	
	```
	kubectl describe secret $(kubectl describe serviceaccount jenkins-user --namespace=jenkins-cluster | grep Token | awk '{print $2}') --namespace=jenkins-cluster
	```

3. Get the url of kubernetes master (you need to run the command on k8s master node): 

	```
	kubectl cluster-info
	```

4. Install [Kubernetes plugin](https://plugins.jenkins.io/kubernetes/)

5. Create secret text by going to manage jenkins -> manage credentials -> press one item of the "store" e.g. "jenkins" -> "global credentials" -> "add credentials" -> choose "system" and paste the output from step 2 to "secret" field

6. Configure the connection between jenkins master and kubernetes cluster (under Manage Jenkins -> Configure System -> Cloud). Sample configuration:
	
	```
	Name: team-k8s
	Kubernetes cluster: https://xx.xx.xx.xx:6443 (you get this from step 2)
	Disable https certificate check: marked
	Kubernetes Namespace: jenkins-cluster
	Credentials: xxx (choose the credentials id from step 4)
	Direct Connection: marked

	and press "Test Connection"

	```

7. Continue to configure the Pod template (it is on the same page) if the connection is successfull:

	```
	Name: k8s-java-openjdk
	Namespace: jenkins-cluster
	Label: k8s-java-pod
	Containers:
		Name: k8s-java-container
		Docker image: openjdk
	ImagePullSecrets:
		Name: xxx (optional)
	Node Selector: kubernetes.io/hostname=node1 -> you can get through kubectl get node --show-labels
	```

8. On pipeline script you need to specify the node and the container name, example:

	```
	node('k8s-java-pod') {
		// do something if needed

		conainer('k8s-java-container') {
			// do something here
		}
	}
	```



Additional information
----------------------

1. [List of Docker images](node) that can be used as Jenkins slave / node

2. [Sample of using in Jenkins pipeline](pipeline)
