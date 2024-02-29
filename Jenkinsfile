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
//                 sh 'mvn -B -DskipTests clean package'
                sh 'mvn clean package'
            }
        }
        // stage('Install Docker') {
        //     steps {
        //         script {
        //             sh 'apt-get update'
        //             sh 'apt-get install -y apt-transport-https ca-certificates curl software-properties-common'
        //             sh 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg'
        //             sh 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null'
        //             sh 'apt-get update'
        //             sh 'apt-get install -y docker-ce docker-ce-cli containerd.io'
        //         }
        //     }
        // }

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
                    sh 'docker tag tharshiey/docdeployment:${TAG} tharshiey/docdeployment:latest'

                }
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    // sh 'docker login -u tharshiey -p Test_1user'
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_credential') {
                         docker.image("tharshiey/docdeployment:${TAG}").push()
                         docker.image("tharshiey/docdeployment:latest").push()
                    // sh 'docker push tharshiey/docdeployment:${TAG}'
                    // sh 'docker push tharshiey/docdeployment:latest'
                    }
                }
            }
        }

        stage('Deploy'){
            steps {
                sh "docker stop docdeployment | true"
                sh "docker rm docdeployment | true"
                sh "docker run --name docdeployment -d -p 8082:8082 tharshiey/docdeployment:${TAG}"
//                 sh "docker run -d -p 8082:8082 tharshiey/docdeployment:${TAG}"
            }
        }
    }
}
