pipeline {
  agent any
  stages {
    stage('test') {
      steps {
      sh "ssh ubuntu@${TEST_IP} < scripts/test.sh"
      }
      }
    stage('deploy') {
      steps {
      sh "./scripts/deployscript.sh"
      }
      }
  }
}
