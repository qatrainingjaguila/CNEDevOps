pipeline {
  agent any
  stages {
    stage('test') {
      steps {
      sh "ssh -oStrictHostKeyChecking=no ubuntu@34.245.37.14 < scripts/test.sh"
      sh "ls"
      }
      }
    stage('deploy') {
      steps {
      sh "./scripts/deployscript.sh"
      }
      }
  }
}
