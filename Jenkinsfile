pipeline {
  agent any

  environment {
    DOCKER_PASSWORD = credentials('DOCKER_PASSWORD')
  }

  stages {


    stage('greeting') {
      steps {
        sh '''
          echo "hello moon"
'''
      }
    }
    stage('run test') {
      steps {
        sh '''
          docker-compose build
          docker-compose run web ./scripts/setup.sh rails test
'''
      }
    }
    stage('docker clean') {
      steps {
        sh '''
          docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
          docker system prune -f
'''
      }
    }
    stage('build image') {
      steps {
        sh '''
          docker build -t shruti17/jukebox:$BUILD_NUMBER .
'''
      }
    }
    stage('login and push') {
      steps {
        sh '''
          docker login -u shruti17 -p $DOCKER_PASSWORD
          docker push shruti17/jukebox:$BUILD_NUMBER
'''
      }
    }
    stage('deply to k8s') {
      steps {
        sh '''
          envsubst < deployment.yaml | kubectl apply -f -
'''
      }
    }

  }
}