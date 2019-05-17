pipeline {
  agent any
  stages {
    stage('predev-build-enviromentresources') {
      steps {
        build 'predev-build-enviromentresources'
      }
    }
    stage('predev-build-changetracking') {
      steps {
        build 'predev-build-changetracking'
      }
    }
    stage('predev-build-dataservices.xml') {
      steps {
        build 'predev-build-dataservices.xml'
      }
    }
    stage('predev-build-brcore') {
      steps {
        build 'predev-build-brcore'
      }
    }
    stage('predev-build-excelservices') {
      steps {
        build 'predev-build-excelservices'
      }
    }
    stage('predev-build-notificationservices') {
      steps {
        build 'predev-build-notificationservices'
      }
    }
    stage('predev-build-marketplace') {
      steps {
        build 'predev-build-marketplace'
      }
    }
    stage('predev-deploy-asyncservice') {
      steps {
        build 'predev-deploy-asyncservice'
      }
    }
  }
}