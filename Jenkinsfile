pipeline {
  agent any
  stages {
    stage('test') {
      steps {
      sh "./scripts/testscript.sh"
      }
      }
    stage('deploy') {
      steps {
      sh "./scripts/deployscript.sh"
      }
      }
  }
}
