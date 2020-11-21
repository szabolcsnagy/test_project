
pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
  }
  stages {
    stage ('Build') {
      steps {
          sh 'node --version'
          echo "Building ${BUILD_ID}"
      }
    }
  }
}