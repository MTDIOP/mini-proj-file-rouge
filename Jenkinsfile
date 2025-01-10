pipeline {
     environment {
       ID_DOCKER ="mortalla"
       PORT_EXPOSED = "${WEB_PORT}"
       IMAGE_NAME = "ic-webapp"
       CTN_NAME = "ic-webapp-ctn"
       IMAGE_TAG = "latest"
       STAGING = "${ID_DOCKER}-staging"
       PRODUCTION = "${ID_DOCKER}-production"
     }
     
     agent none
     stages {
         stage('Build image') {
             agent any
             steps {
                script {
                  sh 'docker build -t ${ID_DOCKER}/$IMAGE_NAME:$IMAGE_TAG .'
                }
             }
        }

        stage('Run container based on builded image') {
            agent any
            steps {
               script {
                 sh '''
                    echo "Run Container"
                    docker run --name $CTN_NAME -d -p ${PORT_EXPOSED}:80 -e PORT=80 ${ID_DOCKER}/$IMAGE_NAME:$IMAGE_TAG
                    sleep 5
                 '''
               }
            }
       }

       stage('Test image') {
           agent any
           steps {
              script {
                sh '''
                  echo "test pass"
                '''
              }
           }
      }

      stage('Clean Container') {
          agent any
          steps {
             script {
               sh '''
                 echo "Clean Environment"
                 docker stop $CTN_NAME
                 docker rm -f $CTN_NAME || echo "container does not exist"
               '''
             }
          }
     }

     stage ('Login and Push Image on docker hub') {
          agent any
        environment {
           DOCKERHUB_PASSWORD  = credentials('dockerhub')
        }            
          steps {
             script {
               sh '''
                   echo $DOCKERHUB_PASSWORD | docker login -u $ID_DOCKER --password-stdin https://index.docker.io/v2/
                   docker login -u $ID_DOCKER -p $DOCKERHUB_PASSWORD
                   docker push ${ID_DOCKER}/$IMAGE_NAME:$IMAGE_TAG
               '''
             }
          }
      }    
  }
    post {
       success {
         slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
         }
      failure {
            slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
          }   
    }
}