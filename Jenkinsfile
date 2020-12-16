pipeline{
    agent {
        kubernetes {
            yamlFile 'agentpod.yml'
        }
    }
    stages{
        stage("Test Terraform files"){
            steps{
                container('ubuntu'){
                    echo "========Executing Test case for Terraform files======="
                    sh "apt install linuxbrew-wrapper"
                    dir('terraform') {
                        sh "echo \$(pwd)"
                        sh "docker run --rm  -v \"\$(pwd):/src\" liamg/tfsec -f junit /src > tfsec_test.xml"
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
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}