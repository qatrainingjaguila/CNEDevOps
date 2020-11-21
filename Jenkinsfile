pipeline {
  agent any
  environment{
    KUBE_SECRET = credentials('KUBE_SECRET_FILE')
  }
  stages {
    stage('Run tests') {
      steps {
      sh "ssh -oStrictHostKeyChecking=no ubuntu@54.74.37.110 < scripts/test.sh"
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
