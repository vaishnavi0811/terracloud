pipeline{
    agent {
        kubernetes {
            yamlFile 'agentpod.yml'
        }
    }
    stages{
        stage("Test Terraform files"){
            steps{
                echo "========Executing Test cae for Terraform files======="
                dir('terraform') {
                   docker run --rm -it -v "$(pwd):/terraform" liamg/tfsec -f junit terraform  > tfsec_test.xml
                }  
            }
            post{
                always{
                    echo "========always========"
                    sh "echo $(pwd)"
                    junit checksName: 'Terraform security checks', testResults: "terraform/tfsec_test.xml"
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