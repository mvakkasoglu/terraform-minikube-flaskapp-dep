pipeline {
    agent {
        node {
            label "master"
        } 
    }
    triggers {
        pollSCM '* * * * *'
    }

    stages {
        stage('Clean up') {
			steps {
				script {
					sh 'rm -rf terraform-minikube-flaskapp-dep'
				}
			}
		}
        stage('fetch_latest_code') {
            steps {
                script{
                    sh 'git clone https://github.com/mvakkasoglu/terraform-minikube-flaskapp-dep.git'
                }
            }
        }

        stage('TF Init&Plan') {
            steps {
                script {
                    dir('./terraform-minikube-flaskapp-dep') {
                       sh '/usr/local/bin/terraform init'
            //         sh '/usr/local/bin/terraform plan'
                    }
                }
            }      
        }

        stage('TF Apply') {
            steps {
                script {
                    dir('./terraform-minikube-flaskapp-dep') {
                        sh '/usr/local/bin/terraform apply -input=false -auto-approve'
                    }
                }
            }
        }
        
        stage('Show namespaces') {
            steps {
                sh '/usr/local/bin/kubectl get all --all-namespaces'
            }
        }
    } 
  }