pipeline{
    agent {
        kubernetes {
            yamlFile 'agentpod.yml'
        }
    }
    stages{
        stage("Test Terraform files"){
            steps{
                container('tfsec'){
                    echo "========Executing Test case for Terraform files======="
                    dir('terraform') {
                        sh "echo \$(pwd)"
                        sh "tfsec -f junit > tfsec_test.xml"
                    }
                }  
            }
            post{
                always{
                    echo "========always========"
                    dir('terraform') {
                        sh "echo \$(pwd)"
                        sh "ls -lrt"
                        sh "cat tfsec_test.xml"
                        junit checksName: 'Terraform security checks', testResults: "tfsec_test.xml"
                    }
                }
                success{
                    echo "========A executed successfully========"
                }
                failure{
                    echo "========A execution failed========"
                }
            }
        }
    }
}