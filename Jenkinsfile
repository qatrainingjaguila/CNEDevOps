pipeline {
  agent any
  environment{
    KUBE_SECRET = credentials('KUBE_SECRET_FILE')
  }
  stages {
    stage('Run tests') {
      steps {
      sh "ssh -o StrictHostKeyChecking=no ubuntu@34.241.115.51 < scripts/test.sh"
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
      sh "kubectl apply -f $KUBE_SECRET -n project"  
      sh "./scripts/deployscript.sh"
      }
      }
  }
}
