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
                    sh "git tag $BUILD_NUMBER"
                    withCredentials([usernamePassword(credentialsId: 'terraformrepo', passwordVariable: 'git_password', usernameVariable: 'git_user')]){
                        sh "git push http://eyctp@dev.azure.com/eyctp/terracloud/_git/iaas"
                    }
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