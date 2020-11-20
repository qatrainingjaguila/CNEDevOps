# Cloud Native DevOps Project

### Resources:
* JIRA Board: https://qatraineejaguila.atlassian.net/secure/RapidBoard.jspa?rapidView=1&projectKey=PCI&view=planning&selectedIssue=PCI-7&epics=visible&issueLimit=100

## Contents
* [Brief](#brief)
   * [Additional Requirements](#additional-requirements)
* [Architecture](#architecture)
   * [Infrastructure](#Infrastructure)
* [Project Tracking](#project-tracking)
* [Testing](#testing)
* [Known Issues](#known-issues)
* [Future Improvements](#future-improvements)
* [Authors](#authors)

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
JUnit is used to run unit tests on the app. These are designed to assert that if a certain function is run, the output should be a known value.

The ecl emma extension to Spring produces a coverage report to show how much of the code in the app has been successfully tested. This is shown below

![coverage][coverage]

## User Documentation



## Future Improvements
There are a number of improvements I would like to implement (outside of current bugs):
* Store Docker credentials in Jenkins credentials
* Utilise HTTPS

## Authors
Juan Carlos Aguila

[erd1]: 
[coverage]: 
[trello]: 