pipeline {
    agent any
    tools {
      maven 'maven_home'
    }
    environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
//                 sh 'mvn clean package'
            }
        }
        stage('Install Docker') {
            steps {
                script {
                    sh 'curl -fsSL https://get.docker.com -o get-docker.sh'
                    sh 'sh get-docker.sh'
                }
            }
        }

        stage('Verify Docker') {
             steps {
                  script {
                      sh 'docker --version'
                  }
             }
        }

//         stage('Test') {
//             steps {
//                 sh 'mvn test'
//             }
//             post {
//                 always {
//                     junit 'target/surefire-reports/*.xml'
//                 }
//             }
//         }

        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t tharshiey/docdeployment:${TAG} .'
                    sh 'docker tag tharshiey/docdeployment:24.2.33 tharshiey/docdeployment:latest'

                }
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    sh 'docker login -u tharshiey -p Test_1user'
//                     docker.withRegistry('https://registry.hub.docker.com', 'docker_credential') {
//                          docker.image("tharshiey/docdeployment:${TAG}").push()
//                          docker.image("tharshiey/docdeployment:latest").push()
                    sh 'docker push tharshiey/docdeployment:24.2.33'
                    sh 'docker push tharshiey/docdeployment:latest'
//                     }
                }
            }
        }
//         stage('Deploy') {
//             steps {
//                 script {
//                           deploy adapters: [tomcat9(credentialsId: 'tomcat_credential', path: '', url: 'http://dayal-test.letspractice.tk:8081')], contextPath: '/pipeline', onFailure: false, jar: 'target/*.jar'
//                         }
//             }
//         }
        stage('Deploy'){
            steps {
//                 sh "docker stop docdeployment | true"
//                 sh "docker rm docdeployment | true"
//                 sh "docker run --name docdeployment -d -p 9004:8082 tharshiey/docdeployment:${TAG}"
                sh "docker run -d -p 8082:8082 tharshiey/docdeployment:${TAG}"
            }
        }
    }
}