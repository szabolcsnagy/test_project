pipeline {
  // environment{
  //   registry='my-registry.domain'
  //   dockerImage=''
  // }
  agent none
  stages {
    stage ('Build') {
      agent {
        dockerfile {
          filename 'Dockerfile'
          additionalBuildArgs '-t my-registry.domain/test-prj:v1'
          registryUrl 'https://my-registry.domain/'
          // registryCredentialsId 'myPredefinedCredentialsInJenkins'
        }
      }
      
      steps {
          // runs inside the container
          sh 'node --version'
          sh 'which node'
          sh 'cd /srv/test_project && yarn test'
          echo "Building: ${BUILD_TAG}"
          // script {
          //   docker.withRegistry('my-registry.domain'){
          //     docker.push 'test-prj:v1'
          //   }
          //   // dockerImage = docker.image('my-registry.domain/test-prj:v1')

          // }
      }
    }
    stage ('Remount for more tests') {
      agent {
        docker {
          image 'my-registry.domain/test-prj:v1'
        }
      }
      steps {
        // runs inside the container as well
        sh 'ls -la /srv'
        sh 'hostname'
        // script {
        //   def img = docker.image('my-registry.domain/test-prj:v1')
        //   img.push()
        // }
      }
    }
    stage('Push to Registry') {
      steps {
        script {
          def img = docker.image('my-registry.domain/test-prj:v1')
          img.push()
        }
      }
    }
  }
  post {
    always {
      script {
          // Jenkins needs context to know where to remove the image
            docker.withServer('tcp://docker:2376') {
              script{
                // get the actual image id because deleting by ID will remove all tagged version of the same image
                // Deleting by tag only untag the image if there is an other tag for that image
                imageID=sh(returnStdout:true, script:'docker images --filter=reference=my-registry.domain/test-prj:v1 --format "{{.ID}}"')
                println imageID
                sh("docker rmi -f ${imageID}")
              }
              
            }
          }
    }
  }
}