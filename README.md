# Cloud Native DevOps Project

### Resources:
* JIRA Board: https://qatraineejaguila.atlassian.net/secure/RapidBoard.jspa?rapidView=1&projectKey=PCI&view=planning&selectedIssue=PCI-7&epics=visible&issueLimit=100

## Brief
The brief provided to us for this project sets the following out as its overall objective:
"This application is a simple Flask application, ready to be deployed, for your SFIA2 project."
The application must:
* Be deployed to a Virtual Machine for testing
* Be deployed in a managed Kubernetes CLuster for production
* Make use of a managed Database solution

In layman's terms this means our applications must use technologies that we have learned over the course of the training in order to continuously test and deploy the application supplied to us.

### Additional Requirements
In addition to what has been set out in the brief, I am also expected to achieve additional requirements which are as follows:
* A JIRA Kanban board
* The application must be deployed using containerisation and orchestration tools
* The application must be tested through the CI pipeline
* The project must make use of two managed Database Servers: 1 for Testing and 1 for Production.
* If a change is made to the code base, Webhooks should be used so that Jenkins recreates and redeploys the changed application.
* The infrastructure for the project should be configured using an infrastructure management tool (Infrastructure as Code).
* As part of the project, you need to create an Ansible Playbook that will provision the environment that your CI Server needs to run.
* The project must make use of a reverse proxy to make your application accessible to the user.

## Architecture
### Infrastructure
Pictured below is an infrastructure diagram showing the architecture.


![ERD][erd1]


Terraform is used to provision the RDS instances, Test VM and CI Server VM.  
Ansible is used to remotely set up the VM environments and Jenkins is used to automate the testing and deployment.  
The Jenkins pipeline will be set up using webhooks to trigger a build every time a push is made to the VCS (Github).  
It will then test the new code, and push to Dockerhub if successful.  
The latest image is then pulled down by Kubernetes to update the live application.

## Application
The application is a Flask app running in 2 microservices(frontend and backend).
* When a request is made to the app, the frontend service makes a GET request to the backend service.
* The backend service using a database connection to quey the database and return a result.
* The frontend service serving up a simple HTML (index.html) to display the result


## Project Tracking
JIRA was used to track the progress of the project (pictured below). 
Here's the link to the board:https://qatraineejaguila.atlassian.net/jira/software/projects/PD/boards/4

![trello][trello]


## Testing
The app is tested using pytest. The repo is cloned into a VM and run with docker-compose, connecting to a test RDS database.
Below is a coverage report that can be output by pytest.

![coverage][coverage]

## User Documentation
Terraform is used to provision the AWS infrastructure. It is worth noting that the variables files for the EC2 and RDS modules are not on Github,
so need to be manually defined and created. In addition to this, a secret.yaml file needs to be created in order for the app to be deployed to Kubernetes.
A template is included in the K8S folder. The instances are set up to utilise an existing key pair, so ensure these are set in the variables.

### Post Terraform
After Terraform has completed, you will need to set up the environments for the Test VM and CI Server. We will use Ansible to do this.
Using the terraform output(an example shown below), replace the DATABASE_URI and TEST_DATABASE_URI in the secret.yaml, which is required for Kubernetes.
The SSH IP in the Jenkinsfile will also need to be replaced with the IP of the Test VM.

![terraform][terraform]

Use the following command structure along with the output of the Terraform apply to get the outputs for the Jenkins and test VMs.
_ansible-playbook -i 'jenkins ip' --user ubuntu CIplaybook.yaml_

Repeat this using the IP for the Test VM with the same user, using TestVMplaybook.yaml.

Once this has completed, the following steps must be taken to set up the environment:
* SSH into the Jenkins VM as ubuntu
* Set the jenkins user password with _sudo passwd jenkins_
* Add jenkins to sudoers with ALL=(ALL:ALL) NOPASSWD:ALL and to the docker group _sudo usermod -aG docker jenkins_
* Switch to jenkins user 
* Login to docker hub with _sudo docker login_
* Authenticate with aws cli and connect to the cluster with the cluster name you set in Terraform
_aws eks --region xxx update-kubeconfig --name xxx_
* To test create the project namespace with _kubectl create ns project_. This is required for the app to deploy to Kubernetes.
* Retrieve the initial admin password with _cat /var/lib/jenkins/secrets/initialAdminPassword_

We will also manually set up the databases(using the endpoints specified in the uri output):
Copy in/run the Create.sql script in both endpoints to create the test and user databases.
_mysql -h amazonrdsendpoint -P 3306 -u admin -p_ 
Copying the sql script in should look similar to below:

![database][database]

### Test VM setup
Jenkins will need SSH access in order to run the tests on the test vm, so a key pair needs to be created in the jenkins user
and the public key copied to the .ssh/authorized_keys file in the Test VM to allow this.
Add the user _ubuntu_ to the docker group, which need a reload to take effect.
Docker compose will need to be made executable with _sudo chmod +x /usr/local/bin/docker-compose_
Finally, set the environment variables for DATABASE_URI, TEST_DATABASE_URI and SECRET_KEY in /etc/profile 

### Jenkins
Navigate to the Jenkins_IP:8080 and use the initialAdminPassword retrieved from the Jenkins user
Create a new pipeline, using webhooks, and create the corresponding webhook in the settings tab of the git repo using jenkins_ip:8080/github-webhook/
Create the secret file credential 'KUBE_SECRET_FILE' and upload your secret.yaml with the new URIs
_Credentials > System > Global Credentials > Add credentials_


The pipeline has now been set up. Run a test build to ensure the pipeline has been configured correctly.


## Future Improvements
There are a number of improvements I would like to implement (outside of current bugs):
* Store Docker credentials in Jenkins credentials
* Make use of the Docker plugin
* Utilise HTTPS
* Deploy using the Kubernetes plugin

## Authors
Carlos Aguila

## Acknowledgements
Luke Benson, DevOps trainer

[erd1]: https://i.imgur.com/kd02nd3.png
[coverage]: https://i.imgur.com/wfmA2u1.png
[trello]: https://i.imgur.com/dd9pe6h.png
[terraform]: https://i.imgur.com/FMEtnzx.png
[database]: https://i.imgur.com/oCGsesY.png