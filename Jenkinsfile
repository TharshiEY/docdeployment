pipeline {
    agent any
//     tools {
//       maven 'maven-4.0.0'
//     }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
//                 sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                          deploy adapters: [tomcat9(credentialsId: 'tomcat_credential', path: '', url: 'http://dayal-test.letspractice.tk:8081')], contextPath: '/pipeline', onFailure: false, jar: 'target/*.jar'
                        }
//                 sh 'make publish'
            }
        }
    }
}