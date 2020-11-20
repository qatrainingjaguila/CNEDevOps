pipeline {
  agent any
  stages {
    stage('Run tests') {
      steps {
      sh "ssh -oStrictHostKeyChecking=no ubuntu@34.245.37.14 < scripts/test.sh"
      sh "ls"
      }
      }
    stage('push images to dockerhub') {
      steps {
      sh "./scripts/pushscript.sh"
      }
      }  
    stage('deploy') {
      steps {
      sh "./scripts/deployscript.sh"
      }
      }
  }
}
