pipeline {
    agent any

    environment {
        K8S_SERVER_URL = 'https://E07A3DE46850F6161DCA6712B39CA408.gr7.ap-south-1.eks.amazonaws.com'
    }

    stages {
        stage('Deploy To Kubernetes') {
            steps {
                withKubeCredentials(kubectlCredentials: [[
                    caCertificate: '',
                    clusterName: 'EKS-1',
                    contextName: '',
                    credentialsId: 'k8-token',
                    namespace: 'webapps',
                    serverUrl: "${env.K8S_SERVER_URL}"
                ]]) {
                    sh 'kubectl apply -f deployment-service.yml'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                withKubeCredentials(kubectlCredentials: [[
                    caCertificate: '',
                    clusterName: 'EKS-1',
                    contextName: '',
                    credentialsId: 'k8-token',
                    namespace: 'webapps',
                    serverUrl: "${env.K8S_SERVER_URL}"
                ]]) {
                    sh 'kubectl get svc -n webapps'
                }
            }
        }
    }
}

