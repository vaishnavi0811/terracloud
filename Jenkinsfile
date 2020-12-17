pipeline{
    agent {
        kubernetes {
            yamlFile 'agentpod.yml'
        }
    }
    stages{
        stage("Test Terraform files"){
            steps{
                echo "========Executing Test case for Terraform files======="
                container('tfsec'){ 
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
                        junit checksName: 'Terraform security checks', testResults: "tfsec_test.xml"
                    }
                }
                success{
                    echo "Terraform test case passed"
                }
                failure{
                    echo "Terraform test case failed"
                }
            }
        }
        stage("Commit to Main"){
            steps{
                echo "====++++executing Deploy Terraform++++===="
                container('tfsec'){
                    sh "git checkout main"
                    sh "git merge developer"
                }
            }
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++Deploy Terraform executed successfully++++===="
                }
                failure{
                    echo "====++++Deploy Terraform execution failed++++===="
                }
        
            }
        }
    }
}