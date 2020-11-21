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

In layman's terms this means our applications must use technologies that we have learned over the course of the training in order to continuously test and deploy the application supplied to us

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
Pictured below is an infrastructure diagram showing the architecture of your database.


![ERD][erd1]



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

![coverage][coverage]

## User Documentation
Terraform is used to provision the AWS infrastructure. It is worth noting that the variables files for the EC2 and RDS modules are not on Github,
so need to be manually defined and created. In addition to this, a secret.yaml file needs to be created in order for the app to be deployed to Kubernetes.
An template is included in the K8S folder. The instances are set up to utilise an existing key pair, so ensure these are set in the variables.

### Post Terraform
After Terraform has completed, you will need to set up the environments for the Test VM and CI Server. We will use Ansible to do this.
Use the following command structure along with the output of the Terraform apply to get the outputs for the Jenkins and test VMs.
Using the terraform output, replace the DATABASE_URI and TEST_DATABASE_URI in the secret.yaml, which is required for Kubernetes.

_ansible-playbook -i 'jenkins ip' --user ubuntu CIplaybook.yaml_

Repeat this using the IP for the Test VM with the same user, using TestVMplaybook.yaml.

Once this has completed, the following steps must be taken to set up the environment:
* SSH into the Jenkins VM as ubuntu
* Add jenkins to sudoers and the docker group
* Switch to jenkins user 
* Login to docker hub
* Authenticate with aws cli and connect to the cluster with the cluster name you set in Terraform
* Retrieve the initial admin password from /var/lib/jenkins/secrets/initialAdminPassword

We will also manually set up the databases(using the endpoints specified in the uri output):
Do this for both endpoints.
_mysql -h amazonrdsendpoint -P 3306 -u admin -ppassword < database/.Create.sql_ 

### Test VM setup
Jenkins will need SSH access in order to run the tests on the test vm, so a key pair needs to be created in jenkins user
and copied to the .ssh/authorized_keys file to allow this.
The ubuntu user will need to be added to the docker group and sudoers, which need a reload to take effect.
Docker compose will need to be made executable with _sudo chmod +x /usr/local/bin/docker-compose_
Finally, set the environment variables for DATABASE_URI, TEST_DATABASE_URI and SECRET_KEY in etc/profile.

### Jenkins
Navigate to the Jenkins_IP:8080 and use the initialAdminPassword retrieved from the Jenkins user
Create a new pipeline, using webhooks, and create the corresponding webhook in the settings tab of the git repo using the jenkins_ip:8080/github-webhook/

After an initial build, the final step is to create the project namespace and copy the secret.yaml file into the /workspace/PIPELINE_NAME/K8S directory.
This will provide the environment variables for the Cluster, and will not be touched since Jenkins only updates the repo.

The pipeline has now been set up.


## Future Improvements
There are a number of improvements I would like to implement (outside of current bugs):
* Store Docker credentials in Jenkins credentials
* Make use of the Docker plugin
* Utilise HTTPS
* Deploy using the Kubernetes plugin

## Authors
Juan Carlos Aguila

[erd1]: 
[coverage]: 
[trello]: 